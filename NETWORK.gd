	extends Control


var http_request : HTTPRequest = HTTPRequest.new()
const SERVER_URL = "http://localhost/SPILLET/db_test.php"
const SERVER_HEADERS = ["Content-Type: application/x-www-form-urlencoded", "Cache-Control: max-age=0"]
var request_queue : Array = []
var is_requesting : bool = false




func _ready():
	randomize()
	add_child(http_request)
	http_request.connect("request_completed",self,"_http_request_completed")
	
	


func _process(delta):
	
	if is_requesting:
		return
		
	if request_queue.empty():
		return
		
	is_requesting = true
	_send_request(request_queue.pop_front())
	
	
			
	
func _http_request_completed(_result, _response_code, _headers, _body):
	is_requesting = false
	if _result != http_request.RESULT_SUCCESS:
		printerr("Error w/ connection: " + String(_result))
		return
	
	var response_body = _body.get_string_from_utf8()
	
	var response = parse_json(response_body)
	if response['error'] != "none":
		printerr("We returned error: " + response['error'])
		return
	else:
		printerr("All is well")
		
	$TextEdit.set_text(response_body)

	
	
func _send_request(request: Dictionary):
	var client = HTTPClient.new()
	var data = client.query_string_from_dict({"data" : JSON.print(request['data'])})
	var body = "command=" + request['command'] + "&" + data
	
	var err = http_request.request(SERVER_URL, SERVER_HEADERS, false, HTTPClient.METHOD_POST, body)
	
	if err != OK:
		printerr("HTTPRequest error: " + String(err))
		return
		
	print("Requesting...\n\tCommand: " + request['command'] + "\n\tBody: " + body)
	
	
func _submit_score():
	var user_name = $PlayerName.get_text()
	var score = $Score.get_text()
	var command = "add_score"
	var data = {"username" : user_name, "score" : score}
	request_queue.push_back({"command" : command, "data" : data})
	
func _get_scores():
	var command = "get_scores"
	var data = {"score_ofset" : 0, "score_number" : 10}
	request_queue.push_back({"command" : command, "data" : data})





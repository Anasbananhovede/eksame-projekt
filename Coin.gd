extends Area2D
var value : int = 10

func coin_pickup():
	pass

func _on_Coin_body_entered(body):
	if body is Player:
		body.collect_coins(value)
		queue_free()
	pass # Replace with function body.

extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





func _on_Area2D_body_entered(body):
	if body.name=="player":
		get_tree().change_scene("You_win.tscn")
	pass # Replace with function body.


func _restart():
	get_tree().change_scene("res://main.tscn")
	pass # Replace with function body.
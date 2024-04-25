extends Node2D
#hej
func _ready():
	$NETWORK._get_player()

func restart():
	get_tree().change_scene("res://main.tscn")




#ALT KODEN ER FÆRDIG





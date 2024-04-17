extends Node2D

func restart():
	get_tree().paused = false
	get_tree().reload_current_scene()

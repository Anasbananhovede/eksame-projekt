extends Node2D



func _on_LinkButton_pressed():
	OS.shell_open("https://protect.worldwildlife.org/page/65217/donate/1?en_og_source=Web_Donation&ea.tracking.id=Web_Topnav&supporter.appealCode=AWE2402OQ18299A01179RX")



func restart():
	get_tree().change_scene("res://main.tscn")
	pass # Replace with function body.


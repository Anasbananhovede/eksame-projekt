extends Node2D

var enemy_health : int = 1
export var skydning : bool = false

export (PackedScene) var Bullet;

func take_damage(damage_in):
	enemy_health -= damage_in
	
	if enemy_health <= 0:
		print("Avvv! jeg er død")
		queue_free()
	pass



func shoot():
	var b = Bullet.instance()
	add_child(b)
	b.transform = $Muzzle.transform
	
	#if player 

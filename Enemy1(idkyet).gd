extends Node2D

export var mortal = true

var enemy_health : int = 1
export var skydning : bool = false
onready var timer: Timer = $ShootTimer
var bullet = preload("res://EnemyBullet.tscn")



func _physics_process(delta):
	pass


func take_damage(sword_in):
	enemy_health -= sword_in
	
	if mortal and enemy_health <= 0:
		print("Avvv! jeg er død")
		queue_free()
	pass

#func _ready():
#	shoot()

func shoot():
	if not skydning : return 
	var direction : float = -1
	var b = bullet.instance()
	b.position = position
	b.position.x+=20*direction
	b.velocity *= direction
	get_tree().get_root().add_child(b)
	



func _on_ShootTimer_timeout():
	shoot()

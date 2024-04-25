extends KinematicBody2D
class_name Enemy


export var mortal: bool = true

var enemy_health : int = 1
export var skydning : bool = false
onready var timer: Timer = $ShootTimer
var bullet = preload("res://EnemyBullet.tscn")

func _ready():
	if mortal:
		$AnimatedSprite.play("jager")
	else:
		$AnimatedSprite.play("Barrel")
		$AnimatedSprite.scale.x = 0.5
		$AnimatedSprite.scale.y = 0.5

func _physics_process(delta):

	pass


func take_damage(beak_in):
	enemy_health -= beak_in
	
	if mortal and enemy_health <= 0:
		print("Avvv! jeg er død")
		queue_free()
	pass



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

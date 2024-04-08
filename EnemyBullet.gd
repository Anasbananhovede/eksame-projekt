extends Area2D


var speed = 50
var direction = Vector2()
var velocity: float = 2.1

func _physics_process(delta):
	direction.x = velocity
	position += direction * speed * delta



	if position.x <= -20:
		queue_free()
		print("gone")

func _on_Area2D_bullet_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(1)
		print("avvvv!!!!")
	queue_free()
	

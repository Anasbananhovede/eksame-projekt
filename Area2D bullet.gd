extends Area2D

var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Area2D_bullet_body_entered(body):
	if body.is_in_group("entity") && body.has_method("take_damage"):
		body.take_damage(1)
	queue_free()
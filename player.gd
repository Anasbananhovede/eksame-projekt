extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var score : int = 0

var player_health = 3

#onready var bounce_raycast = $bounce_raycast
var is_attacking = false
var can_attack = true
var speed : int = 200
var jump_force : int = 400
var gravity : int = 800
var damage = 1
var vel : Vector2 = Vector2()
var grounded : bool = false

func _ready():
	$AttackArea/AttackCollisionShape2D.disabled = true


func _physics_process(delta):
	
	
	$AttackArea/AttackCollisionShape2D.disabled = not is_attacking
	vel.x = 0
	
	if Input.is_action_pressed("ui_left"):
		vel.x -= speed
	
		
	if Input.is_action_pressed("ui_right"):
		vel.x += speed
	
	
	vel = move_and_slide(vel, Vector2.UP)
	
	vel.y += gravity * delta
	
	if Input.is_action_pressed("ui_up") and is_on_floor():
		vel.y -= jump_force
	
	if Input.is_action_just_pressed("attack") and can_attack:
		#hvor lang tid jeg angriber
		is_attacking = true 
		can_attack = false
		
		
		$CollisionShape2D/AnimatedSprite.play("attack")
		$AttackTimer.start(0.5)
	if is_attacking:
		for enemy_body in $AttackArea.get_overlapping_bodies():
			if enemy_body.has_method("take_damage") && enemy_body != self && is_attacking:
				enemy_body.take_damage(damage)
				_on_AttackTimer_timeout()

func _on_AttackTimer_timeout():
	#hvor lang tid indtil næste mulig angreb
	if is_attacking: 
		is_attacking = false
		$AttackTimer.start(1.3)
	else:
		can_attack = true

func _on_AttackArea_body_entered(body):
	print(body.name, is_attacking);
	pass # Replace with function body.


func take_damage(damage_in):
	player_health -= damage_in
	
	if $CollisionShape2D  and player_health <= 0:
		print("Avvv! jeg er død")
		queue_free()
	pass


#var mouse_pos : Vector2
#get_viewport().warp_mouse(mouse_pos)
#mouse_pos.x+=delta*20


func _on_AnimatedSprite_animation_finished():
	if $CollisionShape2D/AnimatedSprite.animation == "attack":
		$CollisionShape2D/AnimatedSprite.play("default")

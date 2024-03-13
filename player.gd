extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var score : int = 0

var hp = 3

onready var bounce_raycast = $BounceRaycast

var speed : int = 200
var jumpForce : int = 400
var gravity : int = 800

var vel : Vector2 = Vector2()
var grounded : bool = false

func _physics_process(delta):
	
	vel.x = 0
	
	if Input.is_action_pressed("ui_left"):
		vel.x -= speed
		$AnimatedSprite.flip_h=false
		
	if Input.is_action_pressed("ui_right"):
		vel.x += speed
		$AnimatedSprite.flip_h=true
	
	vel = move_and_slide(vel, Vector2.UP)
	
	vel.y += gravity * delta
	
	if Input.is_action_pressed("ui_up") and is_on_floor():
		vel.y -= jumpForce


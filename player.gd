extends KinematicBody2D
class_name Player



var player_health: int = 3
var is_attacking: bool = false
var can_attack: bool = true
var speed : int = 200
var jump_force : int = 300
var gravity : int = 800
var damage: int = 1
var vel : Vector2 = Vector2()
var grounded : bool = false
var value: int = 10


func _ready():
	Global.score =  0
	$AttackArea/AttackCollisionShape2D.disabled = true


func _physics_process(delta):

	
	
	
	var collision = move_and_collide(vel*delta)
	
	$AttackArea/AttackCollisionShape2D.disabled = not is_attacking
	vel.x = 0
	
	
	if Input.is_action_pressed("ui_left"):
		vel.x -= speed
		$player_body/AnimatedSprite.flip_h=true
		$AttackArea.scale.x = -1
	
		
	if Input.is_action_pressed("ui_right"):
		vel.x += speed
		$player_body/AnimatedSprite.flip_h=false
		$AttackArea.scale.x = 1
	
	
# gøre at vi kan tage collision skade af enemy, som ikke kan skyde
	if collision and collision.collider is Enemy:
		if collision.collider.skydning == false:
			take_damage(damage)
			
	vel = move_and_slide(vel, Vector2.UP)
	
	vel.y += gravity * delta
	
	if Input.is_action_pressed("ui_up") and is_on_floor():
		vel.y -= jump_force
	
	if Input.is_action_just_pressed("attack") and can_attack:
		#hvor lang tid jeg angriber
		is_attacking = true 
		can_attack = false
		#hvor lang tid angreb funegre
		$player_body/AnimatedSprite.play("Attack")
		$AttackTimer.start(0.5)
	if $player_body/AnimatedSprite.animation != "Attack":
		if abs(vel.x)>1:
			$player_body/AnimatedSprite.play("sprint")
		else:
			$player_body/AnimatedSprite.play("idle")
	
	
	if is_attacking:
		for enemy_body in $AttackArea.get_overlapping_bodies():
			if enemy_body.has_method("take_damage") && enemy_body != self && is_attacking:
				enemy_body.take_damage(damage)
				_on_AttackTimer_timeout()

#hvor lang tid det tager før jeg kan angrebe igen
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

#gøre at player kan tage sakde, og dø
func take_damage(damage_in):
	player_health -= damage_in
	$UI.heart_display(player_health)
	if $player_body  and player_health <= 0:
		#gemme globale variabler
		queue_free()
		get_tree().change_scene("res://GameOver.tscn")
	
	
	pass
	
	if position.x + 40  > $"../enemy2".position.x && position.x < $"../enemy2".position.x + 40 && position.y + 40 > $"../enemy2".position.y && position.y< $"../enemy2".position.y + 40:
		player_health -= damage_in


func _on_AnimatedSprite_animation_finished():
	if $player_body/AnimatedSprite.animation == "Attack":
		$player_body/AnimatedSprite.play("idle")


	
	#gøre at vi tilføjer vaule til score
func collect_coins(value):
	Global.score += value




#skifter scene til you win
func  _on_youwinCOLLISION_body_entered(body):
	if body.name=="player":
		get_tree().change_scene("res://YouWin.tscn")
	pass # Replace with function body.
	pass # Replace with function body.
	
	
	

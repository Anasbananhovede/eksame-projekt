extends Sprite


var player : KinematicBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	player = $"../entities/player"
	position = player.position

# Called when the node enters the scene tree for the first time.

func _process(delta):
	position.x -= (position.x-player.position.x)
	position.y -= (position.y-player.position.y)
	
	pass

extends Label

# Declare member variables here. Examples:
var movement_speed : float = 1.0

enum states { STATIC, FALLING }
var state = states.STATIC


# Called when the node enters the scene tree for the first time.
func _ready():
	movement_speed = randf()*2.0

func _process(delta):
	if state == states.FALLING:
		rect_position.y += movement_speed

func set_speed(speed):
	if speed != null:
		movement_speed = speed

func drop():
	state = states.FALLING
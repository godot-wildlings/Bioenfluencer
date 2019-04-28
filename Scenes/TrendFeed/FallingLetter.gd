extends Label

# Declare member variables here. Examples:
var movement_speed : float = 1.0
var base_speed : float = 60.0

var screen_area : Rect2

enum states { STATIC, FALLING }
var state = states.STATIC


# Called when the node enters the scene tree for the first time.
func _ready():
	movement_speed = randf()*2.0

func _process(delta):
	if state == states.FALLING:
		rect_position.y += movement_speed * base_speed * delta
		if screen_area.has_point(rect_position) == false:
			rect_position.y = screen_area.position.y


func set_speed(speed):
	if speed != null:
		movement_speed = speed

func drop():
	state = states.FALLING
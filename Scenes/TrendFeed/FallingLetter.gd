extends Label

# Declare member variables here. Examples:
var movement_speed : float = 1.0
var base_speed : float = 60.0

var screen_area : Rect2

enum states { STATIC, FALLING }
var state = states.STATIC
var is_in_trending_word : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	movement_speed = randf()*2.0
	set_self_modulate("72792b")


func _process(delta):
	if state == states.FALLING:
		var lower_margin = screen_area.position.y + screen_area.size.y
		rect_position.y += movement_speed * base_speed * delta

		if screen_area.has_point(rect_position) == false:
			if rect_position.y > lower_margin:
				rect_position.y = screen_area.position.y
			else:
				rect_position.y = lower_margin



func set_speed(speed):
	if speed != null:
		movement_speed = speed

func drop():
	state = states.FALLING

func _on_FallingLetter_mouse_entered():
	# light up the letter when they user mouses over it
	if is_in_trending_word:

		# trying various colors from the palette
		set_self_modulate(Color("aed7b9"))

		#set_self_modulate(Color("efdc76"))
		#set_self_modulate(Color("bbd18a"))

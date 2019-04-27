extends Node2D

# trend_letters and letter_speeds need the same indexing for now
var trend_letters = []
var letter_speeds = []

var trend_words = []


var movement_speed : float

func _ready():
	pass

func _on_word_created(word : String, speed: float):
	trend_words.push_back(word)

func _on_give_trend_letter(node_name : String, speed : float):
	movement_speed = speed
	trend_letters.push_back(node_name)
	letter_speeds.push_back(speed)


func _process(delta):

	for i in range(trend_letters.size()):

		if has_node(trend_letters[i]):
			get_node(trend_letters[i]).rect_position.y += letter_speeds[i]

		else:
			pass

#COMMENTED OUT BECAUSE NOT FUNCTIONING

#func _input(event):
#
#	if event is InputEventMouseButton && event.is_action_pressed("mouse_button_left"):
#		for child in get_children():
#			if trend_letters.has(child.name):
#				if event.position == child.get_rect():
#					remove_child(child)
#					print("clicked")
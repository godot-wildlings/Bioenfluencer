extends Node2D

# trend_letters and letter_speeds need the same indexing for now
var trend_letters = []
var letter_speeds = []

var trend_words = []
var word_speeds = []

var movement_speed : float

var frame_ticks : int = 0

func _ready():
	pass

func _on_word_created(word : String, speed: float):
	trend_words.push_back(word)
	word_speeds.push_back(speed)

func _on_give_trend_letter(node_name : String, speed : float):
	movement_speed = speed
	trend_letters.push_back(node_name)
	letter_speeds.push_back(speed)


func _process(delta):
	frame_ticks += 1
	if frame_ticks % 120 == 0:
		print(trend_words)

	for i in range(trend_letters.size()):

		if has_node(trend_letters[i]):
			get_node(trend_letters[i]).rect_position.y += letter_speeds[i]




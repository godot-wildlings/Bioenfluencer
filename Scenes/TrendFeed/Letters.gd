extends Node2D

# trend_letters and letter_speeds need the same indexing for now
var trend_letters = []
var letter_speeds = []

var trend_words = []
var word_speeds = []

var movement_speed : float

var frame_ticks : int = 0

var drop_all_letters : bool = false



func _ready():
	pass

func _on_word_created(word : String, speed: float):
	trend_words.push_back(word)
	word_speeds.push_back(speed)

func _on_give_trend_letter(node_name : String, speed : float):
	movement_speed = speed
	trend_letters.push_back(node_name)
	letter_speeds.push_back(speed)


func _on_Timer_timeout():
	for child in get_children():
		child.drop()


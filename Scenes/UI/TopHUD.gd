extends Panel

# Declare member variables here. Examples:
onready var followers = $HBoxContainer/NumFollowers
onready var blood = $HBoxContainer/NumBlood
onready var sweat = $HBoxContainer/NumSweat
onready var tears = $HBoxContainer/NumTears
onready var week = $HBoxContainer/NumWeek

var ticks : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#warning-ignore:unused_argument
func _process(delta):
	ticks += 1
	if ticks % 30 == 0: # about twice a second
		followers.text = str(Game.player.followers)
		blood.text = str(Game.player.blood)
		sweat.text = str(Game.player.sweat)
		tears.text = str(Game.player.tears)
		week.text = str(Game.week)


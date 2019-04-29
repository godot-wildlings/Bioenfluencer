extends HBoxContainer

# Declare member variables here. Examples:
onready var followers = $NumFollowers
onready var blood = $NumBlood
onready var sweat = $NumSweat
onready var tears = $NumTears
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


extends Label

# Declare member variables here. Examples:
var ticks : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#warning-ignore:unused_argument
func _process(delta):
	ticks += 1
	if ticks % 60 == 0:
		text = str(Game.player.followers)

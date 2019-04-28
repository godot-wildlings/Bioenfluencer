"""
Track properties of the player here. Like followers, or depression
or other forms of currency

Player can also handle a keyboard input requests.

"""

extends Node2D

var followers : int = 100
var anxiety : float = 0.0



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos = get_local_mouse_position()
	var cursor_pos = get_position()
	$Cursor.set_position(mouse_pos)

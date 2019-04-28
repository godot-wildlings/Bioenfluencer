"""
Track properties of the player here. Like followers, or depression
or other forms of currency

Player can also handle a keyboard input requests.

"""

extends Node2D


#warning-ignore:unused_class_variable
var anxiety : float = 0.0

#warning-ignore:unused_class_variable
var player_name : String = "Sam Pejenkin"

#warning-ignore:unused_class_variable
var followers : int  = 500 setget _set_followers

signal player_followers_changed(followers)

func _init():
	Game.player = self

func _ready():
	pass # Replace with function body.

#warning-ignore:unused_argument
func _process(delta):
	var mouse_pos = get_local_mouse_position()
	#var cursor_pos = get_position()
	$Cursor.set_position(mouse_pos)

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):

		Game.main.show_ui()

func _set_followers(new_val : int) -> void:
	if new_val != followers:
		followers = new_val
		emit_signal("player_followers_changed", followers)
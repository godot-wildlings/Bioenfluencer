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
var followers : int setget _set_followers

#warning-ignore:unused_class_variable
var blood : int
#warning-ignore:unused_class_variable
var sweat : int
#warning-ignore:unused_class_variable
var tears : int

var follower_history : Array = []

signal player_followers_changed(followers)

func _init():
	Game.player = self

func _ready():
	reset()

func reset():
	followers = 100 # lost by passing time, gained by selling creatures
	blood = 5 # lost by paying analyst. Never regained
	sweat = 100 # lost by watching feed, creating creatures, regained by passing time
	tears = 0 # gained by chirping and selling creatures. Never lost
	follower_history.clear()

func pass_time(weeks):

	tears = max(tears - randi()%40+10, 0)

	#blood = min(blood + 1, 3)
	# ^^^ Maybe you shouldn't regain blood.

	var most_recent_follower_loss = rand_range(25, 100)
	follower_history.push_back(most_recent_follower_loss)
	followers -= int(most_recent_follower_loss)


	Game.player.sweat = min(Game.player.sweat + 50, 100)



#warning-ignore:unused_argument
func _process(delta):
	var mouse_pos = get_local_mouse_position()
	#var cursor_pos = get_position()
	$Cursor.set_position(mouse_pos)

#warning-ignore:unused_argument
func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):

		Game.main.show_ui()

func _set_followers(new_val : int) -> void:
	if new_val != followers:
		followers = new_val
		emit_signal("player_followers_changed", followers)

func add_income(income : int) -> void:
	followers += income

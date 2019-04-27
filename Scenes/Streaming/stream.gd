extends Node

var followers : int
var followers_gained : int

signal pose_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("pose_changed", get_node("stream_UI/Label2"), "_on_pose_changed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button2_pressed():
	print("You gained " + str(10) + " followers!")


func _on_Button_pressed():
	print("Subscribe to PewDiePie")
	emit_signal("pose_changed")
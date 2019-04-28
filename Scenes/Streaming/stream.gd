extends Node

#EVERYTHING HERE
#is just a draft


var followers : int
var followers_gained : int

var trends

signal pose_changed

func _ready():
	var label = $stream_UI/LeftSide/Label2
	self.connect("pose_changed", label, "_on_pose_changed")

#func _process(delta):
#	pass

func _on_Button2_pressed():

	print("You gained " + str(10) + " followers!")

	_take_Info_From_Creature()

	followers_gained = followers_gained + 10 #+ some randomizing rng unfortunate misfortune #add depression to Bioenfluencer

	_calc_Followers(followers_gained)


func _on_Button_pressed():
	print("Subscribe to PewDiePie")
	emit_signal("pose_changed")

func _calc_Followers(num : int):

	followers = followers + num

func _take_Info_From_Creature():

	var info

	return info

func _on_ReturnToMainButton_pressed():
	Game.main.return_to_main()


extends Node

#EVERYTHING HERE
#is just a draft


var followers : int
var followers_gained : int

var trends

signal pose_changed

func _ready():
	self.connect("pose_changed", get_node("stream_UI/Label2"), "_on_pose_changed")

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
extends Node

var current_level

func _ready():
	pass

func _on_StartButton_pressed():
	
	var load_level = preload("res://Scenes/Streaming/stream.tscn")
	
	remove_child(get_node("main_ui"))
	
	var instance_level = load_level.instance()
	add_child(instance_level)

func _on_QuitButton_pressed():
	get_tree().quit()
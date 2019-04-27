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

func _on_OptionsButton_pressed():
	get_node("main_ui").hide()
	get_node("options_ui").show()


func _on_TextureButton_pressed():
	get_node("options_ui").hide()
	get_node("main_ui").show()
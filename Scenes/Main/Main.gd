extends Node

onready var level_container = $Levels
onready var main_gui = $UI/MainUI
onready var story_container = $UI/IntroStory
onready var story_tabs = $UI/IntroStory/TabContainer


var current_level



func _init():
	Game.main = self

func _ready():
	$AudioStreamPlayer.play()
	story_container.popup()

func load_level(level_name : String ) -> void:
	var levels : Dictionary = {
			"Feed" : "res://Scenes/TrendFeed/TrendFeed.tscn",
			"Chirp" : "res://Scenes/TrendFeed/SwipeStories.tscn",
			"Lab" : "res://Scenes/CraftingLab/CraftingLab.tscn",
			"Store" : ""
		}

	hide_ui()
	remove_old_level()

	var level_scene_path = levels[level_name]
	if level_scene_path != "":
		var level_scene = load(levels[level_name])
		var new_level = level_scene.instance()
		level_container.add_child(new_level)
		current_level = new_level


func hide_ui():
	main_gui.hide()
	if level_container.get_children().size()>0:
		current_level.show()

func show_ui():
	main_gui.show()
	if level_container.get_children().size() > 0:
		current_level.hide()

func remove_old_level():
	if current_level != null and is_instance_valid(current_level):
		current_level.call_deferred("queue_free")

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

func _on_FullScreenButton_pressed():

	if OS.window_fullscreen == false:
		OS.window_fullscreen = true
	else:
		OS.window_fullscreen = false

func _on_NewsFeedButton_pressed():
	load_level("Feed")


func _on_ChirperButton_pressed():
	load_level("Chirp")


func _on_CreatureLabButton_pressed():
	load_level("Lab")


func _on_StoreButton_pressed():
	load_level("Store")


func _on_NextTabButton_pressed():
	print(story_tabs.get_tab_count())
	if story_tabs.get_current_tab() < story_tabs.get_tab_count()-1:
		story_tabs.set_current_tab(story_tabs.get_current_tab()+1)
	else:
		story_container.hide()

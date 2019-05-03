extends Node

onready var level_container = $Levels
onready var main_gui = $UI/MainUI
onready var story_container = $UI/IntroStoryPopup
onready var lose_screen = $UI/LoseStoryPopup
#onready var story_tabs = $UI/IntroStoryPopup/IntroStoryTabs
onready var creature_storage_container = $CreatureStorageContainer

var current_level



func _init():
	Game.main = self

func _ready():
	$AudioStreamPlayer.play()
	story_container.popup()
	if has_node("UI/BGImage"):
		$UI/BGImage.show()
	initialize_buttons()

func initialize_buttons():
	pass


func reset_player_stats():
	Game.player.reset()

func clear_stored_creatures():
	for creature in creature_storage_container.get_children():
		creature.call_deferred("queue_free")

func reset_trends():
	for trend in DataStore.get_genes_array():
		trend.reset()



func load_level(level_name : String ) -> void:
	var levels : Dictionary = {
			"Feed" : "res://Scenes/TrendFeed/TrendFeed.tscn",
			"Chirp" : "res://Scenes/TrendFeed/SwipeStories.tscn",
			"Lab" : "res://Scenes/CraftingLab/CraftingLab.tscn",
			"Stream" : "res://Scenes/Streaming/stream.tscn",
			"Store" : "res://Scenes/Store/Store.tscn",
			"Chart" : "res://Scenes/TrendFeed/TrendsChart.tscn"
		}

	hide_ui()
	remove_old_level()

	var level_scene_path = levels[level_name]
	if level_scene_path != "":
		var level_scene = load(levels[level_name])
		var new_level = level_scene.instance()
		level_container.add_child(new_level)
		current_level = new_level


func return_to_main():
	remove_old_level()
	show_ui()


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

func remove_unlocked_parts():
	# typically when you restart the game
	DataStore.reset_locked_parts()


func store_creature(creature):
	creature.get_parent().remove_child(creature)
	creature_storage_container.add_child(creature)

func get_creature_from_storage(index):
	var creature = creature_storage_container.get_child(index)

#	var copy_creature = creature.instance()
#	creature_storage_container.add_child(copy_creature)
#
#	creature_storage_container.remove_child(copy_creature)
	creature_storage_container.remove_child(creature)
	return creature

func get_stored_creatures():
	return creature_storage_container.get_children()

func pass_time(weeks):
	"""
	each trend will increase number of followers
	"""
	Game.week += 1
	# reduce tears, increase blood
	Game.player.tears = max(Game.player.tears - 50, 0)
	Game.player.blood = min(Game.player.blood + 1, 3)
	Game.player.followers -= int(rand_range(25, 100))
	Game.player.sweat = min(Game.player.sweat + 50, 100)
	if Game.player.followers <= 0:
		lose()
	else:
		var trend_list = DataStore.get_gene_list()
		for trend_name in trend_list:
			DataStore.get_gene(trend_name).pass_time(weeks) # for gene.gd to figure out

		load_level("Chart")



func lose():
	return_to_main()
	lose_screen.show()


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


func _on_story_completed():
	story_container.hide()


func _on_StreamStudioButton_pressed():
	load_level("Stream")


func _on_WTFButton_pressed():
	$UI/MainUI/WTFHelp.show()



func _on_HideHelpButton_pressed():
	$UI/MainUI/WTFHelp.hide()


func _on_PassTimeButton_pressed():

	pass_time(1)


func _on_AnyButton_pressed():
	$ClickNoise.play()


func _on_AnyButton_hovered():
	$HoverNoise.play()


func _onAnyButton_hovered():
	pass # Replace with function body.




func _on_RestartButton_pressed():
	reset_player_stats()
	clear_stored_creatures()
	remove_unlocked_parts()
	reset_trends()
	Game.week = 0
	lose_screen.hide()
	return_to_main()


extends TabContainer

var story_tabs = self
signal story_completed

# Called when the node enters the scene tree for the first time.
func _ready():
	#warning-ignore:return_value_discarded
	connect("story_completed", Game.main, "_on_story_completed")

	initialize_fields()


func initialize_fields():
	#$Tab3/VBoxContainer/PlayerNameEntry.set_text(Game.player.player_name)
	pass


func _on_NextTabButton_pressed():

	if story_tabs.get_current_tab() < story_tabs.get_tab_count()-1:
		story_tabs.set_current_tab(story_tabs.get_current_tab()+1)
	else:
		emit_signal("story_completed")




func _on_FullscreenButton_pressed():
	if OS.window_fullscreen == false:
		OS.window_fullscreen = true
	else:
		OS.window_fullscreen = false
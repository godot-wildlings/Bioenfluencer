extends Node

var current_level

func _ready():
	pass
	#var load_level = preload("res://Scenes/Levels/template_level.tscn")

	#current_level = load_level.instance()
	#self.add_child(current_level)

func _on_Signal_level_changed():
	pass
	#var load_level = preload("res://Scenes/Levels/template_level.tscn")

#	self.remove_child(current_level)
#
#	#current_level = load_level.instance()
#	add_child(current_level)

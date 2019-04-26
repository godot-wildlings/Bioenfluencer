extends Node

var current_level

func _ready():

	var load_level = preload("res://scenes/template_level.tscn")

	current_level = load_level.instance()
	self.add_child(current_level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Signal_level_changed():

	var load_level = preload("res://scenes/template_level.tscn")

	self.remove_child(current_level)

	current_level = load_level.instance()
	add_child(current_level)

##var current_stage
#
#var gameworld_resource = preload("res://gameworld.tscn")
#var battlestage_resource = preload("res://battleworld.tscn")
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#
#	current_stage = gameworld_resource.instance()
#	self.add_child(current_stage)
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#
#	if Input.is_action_just_pressed("k_key"):
#
#		self.remove_child(current_stage)
#
#		current_stage = gameworld_resource.instance()
#		self.add_child(current_stage)
#		current_stage.raise()
#
#func on_Combat_Start():
#
#	self.remove_child(current_stage)
#
#	current_stage = battlestage_resource.instance()
#	self.add_child(current_stage)
#	current_stage.raise()
#
##	print("signal success")
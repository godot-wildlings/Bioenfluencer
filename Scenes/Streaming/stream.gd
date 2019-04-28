"""
Objectives:

Show the creatures on a list in the sidebar.
Allow the player to select a creature from the list.
It should appear in the main window.
Allow the player to 'show off' or 'sell' their creature for followers

"""

extends Node

#EVERYTHING HERE
#is just a draft

onready var creatures_list = $stream_UI/RightSide/CreatureList
onready var display_position = $stream_UI/LeftSide/Position2D

var trends

func _ready():

	populate_creature_list()







func populate_creature_list():
	for i in DataStore.crafted_creatures:
		if i is Creature and is_instance_valid(i):
			creatures_list.add_item(i.creature_name,null, true)



#			creatures_display.add_item(i.creature_name,DataStore.crafted_creatures.texture, true)

#func _process(delta):
#
#	if creatures_display.is_anything_selected():
#
#		for i in creatures_display.get_selected_items():
#			for j in DataStore.crafted_creatures:
#				if j.is_selected():
#
#					var creature_selected = i.instance()
#
#					display_position.add_child(creature_selected)

	pass

func _on_Button2_pressed():


	_take_Info_From_Creature()
	print("You earned " + str(10) + " cash!")

func _take_Info_From_Creature():

	var info

	return info

func _on_ReturnToMainButton_pressed():
	Game.main.return_to_main()

func _input(event):
	if Input.is_action_just_pressed("mouse_button_left"):
		var creature_index = creatures_list.get_item_at_position(get_viewport().get_mouse_position())
		var selected_creature = DataStore.crafted_creatures[creature_index]
		if selected_creature != null:
			var creature = Game.main.get_creature_from_storage(creature_index)
			display_position.add_child(creature)
			print("Booyah", selected_creature.creature_name)

#func _on_CreatureList_item_activated(index):
#	print("activated creature")
#	var activated_creature = creatures_list.get_item(index)
#	display_position.add_child(activated_creature)



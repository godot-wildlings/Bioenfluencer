extends Node

#EVERYTHING HERE
#is just a draft

onready var creatures_display = $stream_UI/RightSide/ItemList
onready var display_position = $stream_UI/Control/Position2D

var trends

func _ready():

	for i in DataStore.crafted_creatures:

		if i is Creature and is_instance_valid(i):
			
			creatures_display.add_item(i.creature_name,null, true)
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


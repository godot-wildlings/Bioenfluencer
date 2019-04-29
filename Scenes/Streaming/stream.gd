"""
Objectives:

Show the creatures on a list in the sidebar.
Allow the player to select a creature from the list.
It should appear in the main window.
Allow the player to 'show off' or 'sell' their creature for followers

"""

extends Control


onready var creatures_list = $VBoxContainer/stream_UI/RightSide/CreatureList
onready var display_position = $VBoxContainer/stream_UI/LeftSide/DisplayPosition
onready var appraise_label = $VBoxContainer/stream_UI/LeftSide/VBoxContainer/AppraisedValueLabel

var creature_on_display

#var trends

func _ready():

	populate_creature_list()



func populate_creature_list():
	for creature in Game.main.get_stored_creatures():
		creatures_list.add_item(creature.creature_name, null, true)


func _on_ReturnToMainButton_pressed():
	if creature_on_display != null and is_instance_valid(creature_on_display):
		Game.main.store_creature(creature_on_display)
	Game.main.return_to_main()


func _on_CreatureList_item_selected(index):
	if creatures_list.is_item_selectable(index) and not creatures_list.is_item_disabled(index):
		var creature = Game.main.get_creature_from_storage(index)
		creature_on_display = creature
		display_position.add_child(creature)
		creatures_list.clear()
		populate_creature_list()


func _on_SellButton_pressed():
	"""
	determine the value of the creature based on it's genes and current trends
	remove the creature from the stage (it's not currently in storage)
	add followers
	"""
	if creature_on_display != null and is_instance_valid(creature_on_display):
		var income = creature_on_display.get_value()
		Game.player.add_income(income)
		Game.player.tears += 1

		creature_on_display.die()




func _on_AppraiseButton_pressed():
	appraise_label.set_text(creature_on_display.creature_name + " will probably generate " + str(creature_on_display.get_value()) + " followers.")

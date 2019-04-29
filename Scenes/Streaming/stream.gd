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
onready var appraise_button = $VBoxContainer/stream_UI/LeftSide/VBoxContainer/HBoxContainer/AppraiseButton
onready var sell_button = $VBoxContainer/stream_UI/LeftSide/VBoxContainer/HBoxContainer/SellButton2

var creature_on_display

#var trends

func _ready():

	populate_creature_list()

	check_sweat_equity()


func check_sweat_equity():
	if Game.player.sweat <= 0:
		Game.player.sweat = 0
		appraise_button.set_disabled(true)


func populate_creature_list():
	for creature in Game.main.get_stored_creatures():
		creatures_list.add_item(creature.creature_name, null, true)


func _on_ReturnToMainButton_pressed():
	Game.main._on_AnyButton_pressed()

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
	Game.main._on_AnyButton_pressed()

	if creature_on_display != null and is_instance_valid(creature_on_display):
		var income = creature_on_display.get_value()
		Game.player.add_income(income)
		Game.player.tears += 1

		creature_on_display.die()




func _on_AppraiseButton_pressed():
	Game.main._on_AnyButton_pressed()

	if creature_on_display != null and is_instance_valid(creature_on_display):
		Game.player.sweat -= 10
		appraise_button.set_disabled(true)
		appraise_label.set_text(creature_on_display.creature_name + " will probably generate " + str(int(creature_on_display.get_value())) + " followers.")

func _process(delta):
	
	if creature_on_display == null:
		
		appraise_button.disabled = true
		appraise_button.modulate = Color(0.5, 0.5, 0.5, 1)
		
		sell_button.disabled = true
		sell_button.modulate = Color(0.5, 0.5, 0.5, 1)
		
	else:
		
		appraise_button.disabled = false
		appraise_button.modulate = Color(1, 1, 1, 1)
		
		sell_button.disabled = false
		sell_button.modulate = Color(1, 1, 1, 1)
	
	pass
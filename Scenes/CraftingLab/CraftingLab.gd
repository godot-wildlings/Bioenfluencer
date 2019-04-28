extends Control

class_name CraftingLab

#warning-ignore:unused_class_variable
export var max_crafting_budget : int = 100
export var crafting_budget : int = max_crafting_budget setget _set_crafting_budget
export var creature_background_tscn : PackedScene = preload("res://Scenes/Creature/CreatureBackground.tscn") as PackedScene
export var draggable_body_part_tscn : PackedScene = preload("res://Scenes/BodyPart/DraggableBodyPart.tscn") as PackedScene
export var disabled_items_color : Color = Color.red
#warning-ignore:unused_class_variable
onready var body_parts : ItemList = $Control/HBoxContainer/VBoxContainer/BodyParts
#warning-ignore:unused_class_variable
onready var staged_body_parts : ItemList = $Control/HBoxContainer/VBoxContainer2/StagedBodyParts
#warning-ignore:unused_class_variable
onready var preview_container : Node2D = $Control/HBoxContainer/MarginContainer/CreaturePreviewContainer
#warning-ignore:unused_class_variable
onready var budget_label : Label = $Control/HBoxContainer/VBoxContainer/CraftingBudgetLabel
onready var craft_creature_button : Button = $Control/HBoxContainer/VBoxContainer2/CraftCreatureButton

signal on_crafting_budget_change
signal crafting_completed

func _ready() -> void:
	Game.crafting_lab = self
	#warning-ignore:return_value_discarded
	connect("on_crafting_budget_change", self, "_on_CraftingLab_crafting_budget_change")
	#warning-ignore:return_value_discarded
	craft_creature_button.connect("pressed", self, "_on_CraftCreatureButton_pressed")

func _set_crafting_budget(new_val : int) -> void:
	if new_val != crafting_budget:
		crafting_budget = new_val
		emit_signal("on_crafting_budget_change")

func _on_CraftingLab_crafting_budget_change() -> void:
	budget_label.text = "CRAFTING BUDGET LEFT\n%s / %s" % [str(crafting_budget), str(max_crafting_budget)]

func _on_CraftCreatureButton_pressed() -> void:
	# clean up the leftovers from the previous creation
	for children in preview_container.get_children():
		preview_container.remove_child(children)
	var amount_of_staged_body_parts : int = staged_body_parts.get_item_count()
	if amount_of_staged_body_parts > 0:
		# instantiate a creature background and put proper body parts in place
		var creature_background : Object = creature_background_tscn.instance()
		preview_container.add_child(creature_background)
		for i in range(amount_of_staged_body_parts):
			var body_part : BodyPart = DataStore.get_body_part(staged_body_parts.get_item_text(i))
			var draggable_body_part : Sprite = draggable_body_part_tscn.instance()
			creature_background.add_child(draggable_body_part)
			draggable_body_part.sprite.texture = body_part.icon
		emit_signal("crafting_completed")

func _on_ReturnToMainButton_pressed():
	Game.main.return_to_main()

extends Control

class_name CraftingLab

export var creature_tscn : PackedScene = preload("res://Scenes/Creature/Creature.tscn") as PackedScene
#warning-ignore:unused_class_variable
onready var body_parts : ItemList = $Control/HBoxContainer/VBoxContainer/BodyParts
#warning-ignore:unused_class_variable
onready var staged_body_parts : ItemList = $Control/HBoxContainer/VBoxContainer2/StagedBodyParts
#warning-ignore:unused_class_variable
onready var preview_container : Node2D = $Control/HBoxContainer/MarginContainer/CreaturePreviewContainer
#warning-ignore:unused_class_variable
onready var craft_creature_button : Button = $Control/HBoxContainer/VBoxContainer2/CraftCreatureButton
onready var creature_name_input : LineEdit = $Control/HBoxContainer/VBoxContainer2/CreatureNameInput
onready var creature_name_label : Label = $CraftingTube/CreatureNameLabel

var ticks : int = 0

var creature_name : String = "CREATURE"

signal crafting_completed

func _ready() -> void:
	Game.crafting_lab = self
	#warning-ignore:return_value_discarded
	craft_creature_button.connect("pressed", self, "_on_CraftCreatureButton_pressed")
	#warning-ignore:return_value_discarded
	connect("crafting_completed", self, "_on_CraftingLab_crafting_completed")

	if not creature_name_input.is_connected("text_changed", self, "_on_CreatureNameInput_text_changed"):
		#warning-ignore:return_value_discarded
		creature_name_input.connect("text_changed", self, "_on_CreatureNameInput_text_changed")

func _on_CraftingLab_crafting_completed() -> void:
	pass
	# relocated to Go to studio button
	#_save_crafted_creature()

func _craft_creature(crafted_creature_name) -> void:
	# clean up the leftovers from the previous creation
	for children in preview_container.get_children():
		preview_container.remove_child(children)
	var amount_of_staged_body_parts : int = staged_body_parts.get_item_count()
	if amount_of_staged_body_parts > 0:
		# instantiate a creature background and put proper body parts in place
		var creature : Object = creature_tscn.instance()
		preview_container.add_child(creature)
		for i in range(amount_of_staged_body_parts):
			var body_part : BodyPart = DataStore.get_body_part(staged_body_parts.get_item_text(i))
			if is_instance_valid(body_part):

				var live_body_part_scene : PackedScene = load("res://Scenes/BodyPart/LiveBodyPart.tscn")
				var spawned_body_part = live_body_part_scene.instance()

				#var spawned_body_part : Sprite = Sprite.new()


				creature.get_node("BodyParts").add_child(spawned_body_part)
				spawned_body_part.texture = body_part.icon

				copy_genes(body_part, spawned_body_part)

				body_parts.add_item(body_part.part_name, body_part.icon)
		staged_body_parts.clear()
		creature_name_label.text = crafted_creature_name
		#creature_name_label.text = preview_container.get_child(0).name
		emit_signal("crafting_completed")
#		print(self.name, " creature name == ", DataStore.crafted_creatures[DataStore.crafted_creatures.size()-1].creature_name)
#		creature_name_label.text = DataStore.crafted_creatures[DataStore.crafted_creatures.size()-1].creature_name


func copy_genes(from_body_part, to_body_part):
	from_body_part.set_genes()
	#print("from_body_part has : ", from_body_part.get_genes().size(), " genes")
	for gene in from_body_part.get_genes():
		#print("Copying gene: " + gene.name + " from " + from_body_part.name + " to " + to_body_part.name  )
		to_body_part.add_gene(gene)


func _save_crafted_creature() -> void:
	if preview_container.get_child_count() < 1:
		print("Could not get creature node from CreaturePreviewContainer")
	else:
		var creature : Creature = preview_container.get_child(0)
		creature.creature_name = creature_name
		#DataStore.crafted_creatures.append(creature)

		relocate_creature_to_storage(creature)

		#print(DataStore.crafted_creatures)

func relocate_creature_to_storage(creature):
	# prevent creature from queuing_free when the lab level is freed
	Game.main.store_creature(creature)

func _on_CraftCreatureButton_pressed() -> void:

	_save_crafted_creature()
	Game.main._on_AnyButton_pressed()

	Game.player.sweat -= 5
	if Game.player.sweat <= 0:
		Game.player.sweat = 0
		Game.player.tears += 50
	_craft_creature(creature_name_input.get_text())




func _on_ReturnToMainButton_pressed():
	Game.main._on_AnyButton_pressed()

	_save_crafted_creature()
	Game.main.return_to_main()



func _on_OnToStudioButton_pressed():
	Game.main._on_AnyButton_pressed()

	_save_crafted_creature()
	Game.main.load_level("Stream")


func _on_CreatureNameInput_text_changed(new_text):
	if new_text != "" and new_text != null:
		creature_name = new_text
		craft_creature_button.disabled = false

#warning-ignore:unused_argument
func _process(delta):
	# probably don't need this every frame.
	ticks += 1
	if ticks % 30 == 0: # around 1/2 second
		if staged_body_parts.get_item_count() == 0:
			craft_creature_button.disabled = true
			craft_creature_button.modulate = Color(0.5, 0.5, 0.5, 1)
		else:
			craft_creature_button.disabled = false
			craft_creature_button.modulate = Color(1, 1, 1, 1)

		pass

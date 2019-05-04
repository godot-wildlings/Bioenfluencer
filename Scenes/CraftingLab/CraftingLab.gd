"""
Moved unlocked parts onto stage
Move staged parts onto preview container
Name Creature
Take creature to studio


"""

# Can we skip the staging area altogether and just put parts on display?


extends Control

class_name CraftingLab

export var creature_tscn : PackedScene = preload("res://Scenes/Creature/Creature.tscn") as PackedScene
#warning-ignore:unused_class_variable
onready var body_parts : ItemList = $Control/HBoxContainer/VBoxContainer/BodyParts
#warning-ignore:unused_class_variable
onready var staged_body_parts : ItemList = $Control/HBoxContainer/VBoxContainer2/StagedBodyParts
#warning-ignore:unused_class_variable
onready var preview_container : Node2D = $Control/HBoxContainer/MarginContainer/CreaturePreviewContainer
var creature_on_display : Creature

#warning-ignore:unused_class_variable
onready var preview_creature_button : Button = $Control/HBoxContainer/VBoxContainer2/PreviewCreatureButton
onready var onto_studio_button : Button = $Control/HBoxContainer/MarginContainer/VBoxContainer/OnToStudioButton
onready var creature_name_input : LineEdit = $Control/HBoxContainer/MarginContainer/VBoxContainer/CreatureNameInput
#onready var creature_name_label : Label = $CraftingTube/CreatureNameLabel

var ticks : int = 0

#var creature_name : String = "CREATURE"

#signal crafting_completed

func _ready() -> void:
	Game.crafting_lab = self
	#warning-ignore:return_value_discarded
	if not preview_creature_button.is_connected("pressed", self, "_on_PreviewCreatureButton_pressed"):
		preview_creature_button.connect("pressed", self, "_on_PreviewCreatureButton_pressed")

	if not creature_name_input.is_connected("text_changed", self, "_on_CreatureNameInput_text_changed"):
		#warning-ignore:return_value_discarded
		creature_name_input.connect("text_changed", self, "_on_CreatureNameInput_text_changed")


func _craft_creature() -> void:
	"""
	put a fully assembled creature in the preview container
	"""
	# clean up the leftovers from the previous creation
	empty_preview_container()

	var amount_of_staged_body_parts : int = staged_body_parts.get_item_count()
	if amount_of_staged_body_parts > 0:
		# instantiate a creature background and put proper body parts in place
		var creature : Object = creature_tscn.instance()
		preview_container.add_child(creature)
		creature_on_display = creature

		for i in range(amount_of_staged_body_parts):
			var body_part : BodyPart = DataStore.get_body_part(staged_body_parts.get_item_text(i))
			if is_instance_valid(body_part):

				var live_body_part_scene : PackedScene = load("res://Scenes/BodyPart/LiveBodyPart.tscn")
				var spawned_body_part = live_body_part_scene.instance()


				creature.get_node("BodyParts").add_child(spawned_body_part)
				spawned_body_part.texture = body_part.icon
				if body_part.audio_stream != null:
					spawned_body_part.add_audio(body_part.audio_stream)

				copy_genes(body_part, spawned_body_part)

				body_parts.add_item(body_part.part_name, body_part.icon)
		staged_body_parts.clear()


func empty_preview_container():
	for children in preview_container.get_children():
		preview_container.remove_child(children)


func copy_genes(from_body_part, to_body_part):
	from_body_part.set_genes()
	#print("from_body_part has : ", from_body_part.get_genes().size(), " genes")
	for gene in from_body_part.get_genes():
		#print("Copying gene: " + gene.name + " from " + from_body_part.name + " to " + to_body_part.name  )
		to_body_part.add_gene(gene)


func _save_crafted_creature() -> void:
	if creature_on_display == null:
		print("Could not get creature node from CreaturePreviewContainer")
	else:
		relocate_creature_to_storage(creature_on_display)


func relocate_creature_to_storage(creature):
	# prevent creature from queuing_free when the lab level is freed
	Game.main.store_creature(creature)

func _on_PreviewCreatureButton_pressed() -> void:

	if preview_creature_button.disabled == false:

		Game.player.sweat -= 5
		if Game.player.sweat <= 0:
			Game.player.sweat = 0
			Game.player.tears += 50
		_craft_creature()

		# pause to let GenericButton.gd signal main to play a noise.
		yield(get_tree().create_timer(0.1), "timeout")
		disable_button(preview_creature_button)
		#_save_crafted_creature()



func _on_ReturnToMainButton_pressed():

	#_save_crafted_creature()
	creature_on_display = null
	Game.main.return_to_main()



func _on_OnToStudioButton_pressed():
	if creature_on_display != null:

		Game.player.sweat -= 10
		_save_crafted_creature()
		creature_on_display = null
		Game.main.load_level("Stream")


func _on_CreatureNameInput_text_changed(new_text):
	if new_text != "" and new_text != null:
		#creature_name = new_text
		if creature_on_display != null:
			creature_on_display.creature_name = new_text


func disable_some_buttons():

	if not stage_has_parts():
		#creature_name_input.editable = false
		disable_button(preview_creature_button)
	else:
		#creature_name_input.editable = true
		enable_button(preview_creature_button)

	if creature_on_display == null:
		disable_button(onto_studio_button)
		creature_name_input.editable = false
	else:
		enable_button(onto_studio_button)
		creature_name_input.editable = true

func stage_has_parts():
	if staged_body_parts.get_item_count() > 0:
		return true
	else:
		return false

func disable_button(button_node : Button):
	button_node.disabled = true
	button_node.modulate = Color.darkgray

func enable_button(button_node : Button):
	button_node.disabled = false
	button_node.modulate = Color.white

#warning-ignore:unused_argument
func _process(delta):
	# probably don't need this every frame.
	ticks += 1
	if ticks % 30 == 0: # around 1/2 second
		disable_some_buttons()

# moved to GenericButton.gd
#func _on_AnyButton_pressed():
#	Game.main._on_AnyButton_pressed(self)
#
#
#func _on_AnyButton_hovered():
#	Game.main._on_AnyButton_hovered(self)


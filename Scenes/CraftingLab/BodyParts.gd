extends ItemList

"""
BodyParts.gd CRAFTING LAB
Render each BodyPart
unlocked parts should be selectable from the list of available parts &
be removed from the list upon selection & added to the \"staging\" list on the left
(in case the weight of the body part does not exceed the players budget left)
"""

func _ready() -> void:
	#warning-ignore:return_value_discarded
	connect("item_selected", self, "_on_BodyParts_item_selected")
	call_deferred("_populate_item_list_body_parts")

func _populate_item_list_body_parts() -> void:
	for part in DataStore.body_parts.values():
		if part is BodyPart:
			print(part.part_name)
			if DataStore.is_body_part_unlocked(part.part_name):
				add_item(part.part_name, part.icon, true)
			else:
				add_item(part.part_name, part.icon, false)

	for i in range(get_item_count()):
		var disabled : bool = not DataStore.is_body_part_unlocked(get_item_text(i))
		set_item_disabled(i, disabled)
		if disabled:
			set_item_custom_bg_color(i, Game.crafting_lab.disabled_items_color)


func _on_BodyParts_item_selected(index : int) -> void:
	if Game.crafting_lab.crafting_budget > 0 and is_item_selectable(index) and not is_item_disabled(index):
		var body_part : BodyPart = DataStore.get_body_part(get_item_text(index))
		if is_instance_valid(body_part):
			if Game.crafting_lab.crafting_budget - body_part.weight > 0:
				Game.crafting_lab.crafting_budget -= body_part.weight
				remove_item(index)
				Game.crafting_lab.staged_body_parts.add_item(body_part.part_name, body_part.icon, true)
		else:
			print("Error, invalid body_part instance in BodyParts.gd (Crafting Lab) -> _on_BodyParts_item_selected")
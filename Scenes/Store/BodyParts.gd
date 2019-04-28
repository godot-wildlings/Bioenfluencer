extends ItemList

"""
BodyParts.gd STORE
"""
func _ready():
	_populate_item_list_body_parts()
	connect("item_selected", self, "_on_BodyParts_item_selected")

func _populate_item_list_body_parts() -> void:
	for part in DataStore.body_parts.values():
		if part is BodyPart:
			if not DataStore.is_body_part_unlocked(part.part_name):
				add_item(part.part_name, part.icon, true)

func _on_BodyParts_item_selected(index : int) -> void:
	if Game.player.money > 0 and is_item_selectable(index) and not is_item_disabled(index):
		var body_part : BodyPart = DataStore.get_body_part(get_item_text(index))
		if is_instance_valid(body_part):
			if Game.player.money - body_part.price > 0:
				Game.player.money -= body_part.price
				remove_item(index)
				Game.crafting_lab.staged_body_parts.add_item(body_part.part_name, body_part.icon, true)
		else:
			print("Error, invalid body_part instance in BodyParts.gd (Store) -> _on_BodyParts_item_selected")
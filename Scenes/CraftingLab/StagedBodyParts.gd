extends ItemList


func _ready() -> void:
	#warning-ignore:return_value_discarded
	connect("item_selected", self, "_on_StagedBodyParts_item_selected")

func _on_StagedBodyParts_item_selected(index : int) -> void:
	if is_item_selectable(index):
		var body_part : BodyPart = DataStore.get_body_part(get_item_text(index))
		if is_instance_valid(body_part):
			remove_item(index)
			Game.crafting_lab.body_parts.add_item(body_part.part_name, body_part.icon, true)
		else:
			print("Error, invalid body_part instance in ItemListBodyParts.gd -> _on_BodyParts_item_selected")
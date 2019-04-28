extends ItemList

func _ready():
	_populate_item_list_body_parts()

func _populate_item_list_body_parts() -> void:
	for part in DataStore.body_parts.values():
		print(part)
		if part is BodyPart:
			print(part.part_name)
			if not DataStore.is_body_part_unlocked(part.part_name):
				add_item(part.part_name, part.icon, true)
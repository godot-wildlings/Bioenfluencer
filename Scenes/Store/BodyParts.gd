extends ItemList
"""
BodyParts.gd STORE
"""
signal selection_change(selected_body_part)

var selected_body_part : BodyPart setget _set_selected_body_part

func _ready() -> void:
	call_deferred("_deferred_ready")

func _deferred_ready() -> void:	
	_populate_item_list_body_parts()
	_add_prices_as_tooltips()
	#warning-ignore:return_value_discarded
	connect("item_selected", self, "_on_BodyParts_item_selected")
	#warning-ignore:return_value_discarded
	connect("selection_change", Game.store, "_on_BodyParts_selection_change")

func _populate_item_list_body_parts() -> void:
	for part in DataStore.body_parts.values():
		if part is BodyPart:
			if not DataStore.is_body_part_unlocked(part.part_name):
				add_item(part.part_name, part.icon, true)

func _add_prices_as_tooltips() -> void:
	for i in range(get_item_count()):
		var body_part : BodyPart = DataStore.get_body_part(get_item_text(i))
		if is_instance_valid(body_part):
			set_item_tooltip(i, str(body_part.price))

func _on_BodyParts_item_selected(index : int) -> void:
	if is_item_selectable(index) and not is_item_disabled(index):
		var body_part : BodyPart = DataStore.get_body_part(get_item_text(index))
		if is_instance_valid(body_part):
			print("valid")
			self.selected_body_part = body_part
		else:
			print("Error, invalid body_part instance in BodyParts.gd (Store) -> _on_BodyParts_item_selected")

func _set_selected_body_part(new_val : BodyPart) -> void:
	if new_val != selected_body_part:
		selected_body_part = new_val
		emit_signal("selection_change", selected_body_part)
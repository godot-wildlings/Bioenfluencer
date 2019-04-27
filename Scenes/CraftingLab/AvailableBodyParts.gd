extends GridContainer

"""
Render each BodyPart
- unlocked: render as CheckButton so that you can select (up to 4) BodyParts
- locked : Render as Button with buy action
"""

func _ready() -> void:
	for part in data_store.body_parts.values():
		if part is BodyPart and data_store.unlocked_body_parts.has(part.part_name):
			part.state = BodyPart.States.GUI
		else:
			print("not unlocked")
			print(part.part_name)
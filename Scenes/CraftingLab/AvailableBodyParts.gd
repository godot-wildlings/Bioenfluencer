extends GridContainer

"""
Render each BodyPart
- unlocked: render as CheckButton so that you can select BodyParts
	(as many as the budget allows (weight property)
- locked : Render as Button with buy action
"""

func _ready() -> void:
	for part in data_store.body_parts.values():
		if part is BodyPart and data_store.unlocked_body_parts.has(part.part_name):
			part.state = BodyPart.States.GUI
		else:
			print("not unlocked : " + part.part_name)
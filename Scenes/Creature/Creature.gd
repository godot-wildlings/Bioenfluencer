extends Node2D

class_name Creature

#warning-ignore:unused_class_variable
export var creature_name : String = "Creature"

func _ready():
	pass

func die():
	#probably want some sort of animation here
	call_deferred("queue_free")

func get_value() -> float:
	print(self.name, " ", $BodyParts.get_children())
	var value = 0.0
	for live_body_part in $BodyParts.get_children():
		value += live_body_part.get_value()
	return value


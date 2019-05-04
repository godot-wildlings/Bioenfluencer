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

	var value = 0.0
	var num_parts = $BodyParts.get_child_count()
	if num_parts > 0:
		for live_body_part in $BodyParts.get_children():
			value += live_body_part.get_value()
		value /= num_parts # average, not total
	return value

func make_noise():
	var noisy_parts : Array = []
	for body_part in $BodyParts.get_children():
		if body_part.has_noise():
			noisy_parts.push_back(body_part)

	if noisy_parts.size() > 0:
		noisy_parts[randi()%noisy_parts.size()].make_noise()



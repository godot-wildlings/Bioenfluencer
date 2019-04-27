extends Node2D

enum BodyPartCategory { HEAD, TORSO, LEGS, TAIL } # Arms?

var genes : Array

export var part_name : String = "BodyPart"
#warning-ignore:unused_class_variable
export(BodyPartCategory) var category : int = BodyPartCategory.HEAD
#warning-ignore:unused_class_variable
export var icon : Texture = preload("res://icon.png") as Texture

enum States { GUI, CREATURE }
var state : int = States.GUI

func _ready() -> void:
	if state == States.GUI:
		$Sprite.scale = Vector2(0.25, 0.25)
	elif state == States.CREATURE:
		$Sprite.scale = Vector2(1, 1)
	data_store.body_parts[part_name] = self
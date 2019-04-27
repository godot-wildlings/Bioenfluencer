extends Node2D

enum BodyPartCategory { HEAD, TORSO, LEGS, TAIL }

var genes : Array

export var part_name : String = "BodyPart"
#warning-ignore:unused_class_variable
export(BodyPartCategory) var category : int = BodyPartCategory.HEAD
#warning-ignore:unused_class_variable
export var icon : Texture = preload("res://icon.png") as Texture


func _ready() -> void:
	data_store.body_parts[part_name] = self
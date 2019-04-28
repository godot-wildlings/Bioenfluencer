extends Node2D

class_name BodyPart

enum BodyPartCategory { HEAD, TORSO, LEGS, TAIL } # Arms?

var genes : Array

export var part_name : String = "BodyPart"
#warning-ignore:unused_class_variable
export(BodyPartCategory) var category : int = BodyPartCategory.HEAD
export var weight : int = 0 # used for crafting
export var price : int = 0 # used in the store
#warning-ignore:unused_class_variable
export var icon : Texture = preload("res://icon.png") as Texture

func _ready() -> void:
	$Sprite.texture = icon
	$Sprite.visible = DataStore.is_body_part_unlocked(part_name)
	DataStore.body_parts[part_name] = self
extends Node2D

class_name CraftingLab

#warning-ignore:unused_class_variable
export var crafting_budget : int = 100

#warning-ignore:unused_class_variable
onready var body_parts : ItemList = $CanvasLayer/Panel/BodyParts
#warning-ignore:unused_class_variable
onready var staged_body_parts : ItemList = $CanvasLayer/Panel2/StagedBodyParts
#warning-ignore:unused_class_variable
onready var preview_container : Node2D = $CreaturePreviewContainer

func _ready() -> void:
	Game.crafting_lab = self
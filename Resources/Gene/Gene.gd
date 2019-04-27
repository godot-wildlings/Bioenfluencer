extends Resource

class_name Gene, "res://Resources/Gene/gene_icon.png"

enum GeneCategory { CATEGORY_MOVEMENT, CATEGORY_COLOR }

export var name : String = "Gene" setget _set_name
#warning-ignore:unused_class_variable
export(GeneCategory) var category : int = GeneCategory.CATEGORY_COLOR
#warning-ignore:unused_class_variable
export var number_of_followers : int = 0
#warning-ignore:unused_class_variable
export var trending_factor : float = 0.0
#warning-ignore:unused_class_variable
export var icon : Texture = preload("res://icon.png") as Texture

func _set_name(new_name : String) -> void:
	name = new_name
extends Resource

class_name Gene, "res://Resources/Gene/gene_icon.png"

enum GeneCategory { CATEGORY_BODY, CATEGORY_MOVEMENT, CATEGORY_COLOR }

export var name : String = "Gene" setget _set_name
export(GeneCategory) var category : int = GeneCategory.CATEGORY_BODY
export var number_of_followers : int = 0
export var trending_factor : float = 0.0

func _set_name(new_name : String) -> void:
	name = new_name
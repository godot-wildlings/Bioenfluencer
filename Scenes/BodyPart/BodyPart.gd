extends Node2D

class_name BodyPart

enum BodyPartCategory { HEAD, TORSO, LEGS, TAIL } # Arms?

#warning-ignore:unused_class_variable
var genes : Array

export var part_name : String = "BodyPart"

export var gene_list : String = ""

#warning-ignore:unused_class_variable
export(BodyPartCategory) var category : int = BodyPartCategory.HEAD

#warning-ignore:unused_class_variable
export var price : int = 0 # used in the store

#warning-ignore:unused_class_variable
export var icon : Texture = preload("res://icon.png") as Texture

func _ready() -> void:
	$Sprite.texture = icon
	$Sprite.visible = DataStore.is_body_part_unlocked(part_name)
	DataStore.body_parts[part_name] = self

	for gene_name in gene_list.split(","):
		gene_name = gene_name.strip_edges() # remove whitespace
		var gene = DataStore.get_gene(gene_name)
		if gene != null:
			genes.push_back(DataStore.get_gene(gene_name))


func get_genes() -> Array:
	return genes

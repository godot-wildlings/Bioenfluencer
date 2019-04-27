extends Node

export var gene_resources_path : String = "res://Resources/Genes"
export var gene_resource_prefix : String = "gene_"

var genes : Dictionary
var unlocked_body_parts : Array
var body_parts : Dictionary

func _ready() -> void:
	unlocked_body_parts = [
		"Lizard Head",
		"Lizard Legs"
	]
	_populate_genes_dict()

func _populate_genes_dict() -> void:
	var dir : Directory = Directory.new()
	if dir.open(gene_resources_path) == OK:
		dir.list_dir_begin(true, true)
		var file_name : String = dir.get_next()
		while (file_name != "" and file_name != " "):
			if not dir.current_is_dir():
				var gene_name : String = file_name
				gene_name = gene_name.replace(gene_resource_prefix, "")
				gene_name = gene_name.replace(".tres", "")
				var preload_path : String = gene_resources_path + "/" + file_name
				genes[gene_name] = load(preload_path)
				file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("An error occurred when trying to access the path.")

func get_gene(gene_name : String) -> Gene:
	if genes.has(gene_name):
		return genes.get(gene_name)
	else:
		print("Gene " + gene_name + " not in gene pool!")
		return null
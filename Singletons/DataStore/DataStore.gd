extends Node

export var gene_resources_path : String = "res://Resources/Genes"
export var gene_resource_prefix : String = "gene_"

var genes : Dictionary
var unlocked_body_parts : Array
var body_parts : Dictionary # populated by BodyPart.gd when BodyParts.tscn is instantiated

# moved to Main.tscn
#var crafted_creatures : Array



# Note: possible body parts are listed in BodyParts.tscn
# unlocked_body_parts compares against part_name
func _ready() -> void:
	reset_locked_parts()
	_populate_genes_dict()

func reset_locked_parts():
	unlocked_body_parts = [
		"Lizard Head",
		"Lizard Legs",
		"Lizard Torso"
	]



func _populate_genes_dict() -> void:
	var dir : Directory = Directory.new()
	if dir.open(gene_resources_path) == OK:
		#warning-ignore:return_value_discarded
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
		push_warning("An error occurred when trying to access the gene resources path.")

func get_genes_array() -> Array: # array of gene objects
	#push_warning("it seems like you're grabbing a lot of genes. careful not to instance them")
	return genes.values()

func get_gene_list() -> Array: # array of strings
	var gene_list : Array = []
	for gene in genes.values():
		gene_list.push_back(gene.name)
	return gene_list

func get_gene(gene_name : String) -> Gene:
	if genes.has(gene_name):
		return genes.get(gene_name)
	else:
		push_warning("Gene " + gene_name + " not in gene pool!")
		return null

func get_random_gene() -> Gene:
	return genes.values()[randi()%genes.size()]

func get_trending_gene() -> Gene:
	# walk the list and grab those with positive slopes
	var trending_genes : Array = []
	for gene in genes.values():
		trending_genes.push_back(gene)
	trending_genes.sort_custom(self, "sort_genes_by_trending")
	if trending_genes.size() > 5:
		trending_genes.resize(5)

	return trending_genes[randi()%trending_genes.size()]

func sort_genes_by_trending(a : Gene, b : Gene):
	if a.trending_factor <= b.trending_factor:
		return true
	return false

func is_body_part_unlocked(body_part_name : String) -> bool:
	return unlocked_body_parts.has(body_part_name)

func get_body_part(body_part_name : String) -> BodyPart:
	if body_parts.has(body_part_name):
		return body_parts.get(body_part_name)
	else:
		print("BodyPart " + body_part_name + " not in body part pool!")
		return null

func unlock_new_body_part(body_part : BodyPart) -> void:
	if is_instance_valid(body_part) and not unlocked_body_parts.has(body_part.name):
		unlocked_body_parts.append(body_part.part_name)
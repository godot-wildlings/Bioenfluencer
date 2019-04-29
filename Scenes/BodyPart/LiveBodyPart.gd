extends Sprite

#warning-ignore:unused_class_variable
var genes : Array = []

#warning-ignore:unused_class_variable
var sale_value : float = 0.0

var value : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_gene(gene):
	genes.push_back(gene)

func get_value() -> float:
	value = 0.0
	for gene in genes:
		value += gene.get_value()
	return value


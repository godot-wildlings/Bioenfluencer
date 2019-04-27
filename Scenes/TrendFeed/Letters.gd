extends Node2D

func _ready():
	pass

func _process(delta):
	
	for child in get_children():
		child.rect_position.y += 2
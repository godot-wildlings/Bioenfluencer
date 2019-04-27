extends Node2D

var trend_letters = []


func _ready():
	pass

func _on_give_trend_letter(node_name : String):
	
	trend_letters.insert(trend_letters.size(), node_name)

func _process(delta):
	
	for child in get_children():
		
		if trend_letters.has(child.name):
			child.rect_position.y += 2
		else:
			pass

#COMMENTED OUT BECAUSE NOT FUNCTIONING

#func _input(event):
#
#	if event is InputEventMouseButton && event.is_action_pressed("mouse_button_left"):
#		for child in get_children():
#			if trend_letters.has(child.name):
#				if event.position == child.get_rect():
#					remove_child(child)
#					print("clicked")
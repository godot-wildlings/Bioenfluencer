extends Area2D

signal level_changed

func _ready():
	
	self.connect("level_changed", get_parent().get_parent(), "_on_Signal_level_changed")
	

func _on_template_level_changer_body_entered(body):
	
	emit_signal("level_changed")
	
	print("LEVEL CHANGED")
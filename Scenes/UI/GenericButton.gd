extends Button

# Declare member variables here. Examples:
export var tool_tip : String

# Called when the node enters the scene tree for the first time.
func _ready():
	set_tooltip(tool_tip)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

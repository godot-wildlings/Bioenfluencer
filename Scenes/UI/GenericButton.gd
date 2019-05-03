extends Button

# Declare member variables here. Examples:
export var tool_tip : String

signal hovered(button_node)
signal clicked(button_node)

# Called when the node enters the scene tree for the first time.
func _ready():
	if tool_tip != null and tool_tip != "":
		set_tooltip(tool_tip)

	if not is_connected("mouse_entered", self, "_on_mouse_entered"):
		#warning-ignore:return_value_discarded
		connect("mouse_entered", self, "_on_mouse_entered")

	if not is_connected("pressed", self, "_on_pressed"):
		#warning-ignore:return_value_discarded
		connect("pressed", self, "_on_pressed")

	# ask Main.gd to make some noises
	#warning-ignore:return_value_discarded
	connect("hovered", Game.main, "_on_AnyButton_hovered")
	#warning-ignore:return_value_discarded
	connect("clicked", Game.main, "_on_AnyButton_clicked")

func _on_mouse_entered():
	if not disabled:
		emit_signal("hovered", self)

func _on_pressed():
	if not disabled:
		emit_signal("clicked", self)

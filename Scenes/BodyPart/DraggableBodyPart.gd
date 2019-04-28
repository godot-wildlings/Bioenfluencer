extends Area2D

onready var sprite : Sprite = $Sprite
var can_grab : bool = false
var grabbed_offset : Vector2 = Vector2()

func _input_event(viewport : Object, event : InputEvent, shape_idx : int):
	if event is InputEventMouseButton:
		can_grab = event.pressed
		grabbed_offset = position - get_global_mouse_position()

func _process(delta : float) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_grab:
		position = get_global_mouse_position() + grabbed_offset
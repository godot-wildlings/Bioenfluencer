extends KinematicBody2D

const UP = Vector2(0,-1)
var motion = Vector2()

export var movement_speed : float = 100
const NO_MOVEMENT : int = 0
export var jump_speed : float = -100

func _ready():
	
#	set_process_input(true)
	set_physics_process(true)

func _physics_process(delta):
	
	motion.y += 10
	
	if is_on_floor():
		
		motion.y = NO_MOVEMENT
		
		if Input.is_action_pressed("spacebar_key"):
			motion.y = jump_speed
	
	if Input.is_action_pressed("d_key") || Input.is_action_pressed("a_key"):
		motion.x = (int(Input.is_action_pressed("d_key"))-int(Input.is_action_pressed("a_key"))) * movement_speed
	else:
		motion.x = NO_MOVEMENT
	
	motion = motion.normalized()
	
	move_and_slide(motion, UP)
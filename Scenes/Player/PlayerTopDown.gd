extends KinematicBody2D

class_name PlayerCharacter

const COLLISION = Vector2(0,0)
var motion = Vector2()

export var movement_speed : float = 100
const NO_MOVEMENT : int = 0

func _ready():

	set_physics_process(true)

func _physics_process(delta):

	if Input.is_action_pressed("d_key") || Input.is_action_pressed("a_key"):
		motion.x = (int(Input.is_action_pressed("d_key"))-int(Input.is_action_pressed("a_key")))
	else:
		motion.x = NO_MOVEMENT

	if Input.is_action_pressed("w_key") || Input.is_action_pressed("s_key"):
		motion.y = (-int(Input.is_action_pressed("w_key"))+int(Input.is_action_pressed("s_key")))
	else:
		motion.y = NO_MOVEMENT

	motion = motion.normalized() * movement_speed

	move_and_slide(motion, COLLISION)
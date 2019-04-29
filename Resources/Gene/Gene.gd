extends Resource

class_name Gene, "res://Resources/Gene/gene_icon.png"

enum GeneCategory { CATEGORY_MISC, CATEGORY_MOVEMENT, CATEGORY_COLOR }

export var name : String = "Gene" setget _set_name
#warning-ignore:unused_class_variable
export(GeneCategory) var category : int = GeneCategory.CATEGORY_MISC
#warning-ignore:unused_class_variable
export var number_of_followers : int = 100

#warning-ignore:unused_class_variable
export var trending_factor : float # rise over run (followers per week)

#warning-ignore:unused_class_variable
export var icon : Texture = preload("res://icon.png") as Texture

var value : float = 0.0
var follower_history : Array = []

func _init():
	trending_factor = rand_range(-1.0, 1.0)
	number_of_followers = int(rand_range(100, 100000))

func _set_name(new_name : String) -> void:
	name = new_name

func pass_time(weeks):
	"""
	every x amount of time (week), followers will go up or down based on trending_factor.
	"""
	follower_history.push_front(number_of_followers)
	number_of_followers += weeks * int(float(number_of_followers) * trending_factor) # can be negative.
	trending_factor += rand_range(-0.1, 0.1)

func get_value() -> float:
	"""
	value is based on number_of_followers, which changes over time.
	"""

	return float(number_of_followers) * 0.1

func get_temporal_value(week) -> int:
	return follower_history[week]
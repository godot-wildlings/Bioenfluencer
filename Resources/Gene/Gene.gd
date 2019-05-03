extends Resource

class_name Gene, "res://Resources/Gene/gene_icon.png"

enum GeneCategory { CATEGORY_MISC, CATEGORY_MOVEMENT, CATEGORY_COLOR }

export var name : String = "Gene" setget _set_name
#warning-ignore:unused_class_variable
export(GeneCategory) var category : int = GeneCategory.CATEGORY_MISC
#warning-ignore:unused_class_variable
export var number_of_followers : int

#warning-ignore:unused_class_variable
export var trending_factor : float # rise over run (followers per week)

#warning-ignore:unused_class_variable
export var icon : Texture = preload("res://icon.png") as Texture

var value : float = 0.0
var follower_history : Array = []

func _init():
	reset()

func reset():
	trending_factor = rand_range(-1.0, 1.0)
	number_of_followers = int(pow(10, randi()%4 + 1))
	follower_history.clear()
#	print(self.name, " has ", str(number_of_followers), " followers")

func _set_name(new_name : String) -> void:
#	print(self.name , " changing name to ", new_name )
	name = new_name

func pass_time(weeks):
	"""
	every x amount of time (week), followers will go up or down based on trending_factor.
	"""
	follower_history.push_back(number_of_followers)
	number_of_followers += weeks * int(float(number_of_followers) * trending_factor) # can be negative.
	trending_factor += rand_range(-0.25, 0.25)
	number_of_followers = max(number_of_followers, 1) # never go to zero

#	print("passing time: ")
#	print(name, ": followers: ", number_of_followers)
#	print(name, ": trending_factor: ", trending_factor)

func get_value() -> float:
	"""
	value is based on number_of_followers, which changes over time.
	"""
	var value = log(number_of_followers)/log(10) * 20 * rand_range(0.5, 1.5)
#	print(self.name, " is valued at ", str(value))
	return value

func get_temporal_value(week) -> int:
	return follower_history[week]

func increase_followers(num_new_followers: int):
	number_of_followers += num_new_followers
	trending_factor += float(num_new_followers)/1000

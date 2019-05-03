extends Container

# Declare member variables here. Examples:
var influencer_names : Array = [
		"Pima Donna",
		"Malcolm Meany",
		"Franklin Kennedy",
		"Arianna Talle",
		"Kim Carmack",
		"Prince Freddy"
	]

var influencer_genders : Array = [
		"her", "his", "their", "her", "hir", "its", "zir"
	]

var influencer_name : String = ""

#warning-ignore:unused_class_variable
var number_followers : float

var gender : String = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	influencer_name = influencer_names[randi()%influencer_names.size()]


func start(mode):
	if mode == "display":
		set_visible(true)
	else:
		set_visible(false)

	gender = influencer_genders[randi()%influencer_genders.size()]
	build_random_face()
	number_followers = pow(10,randi()%4+1)
	print(influencer_name + " has " + str(number_followers) + " followers" )

func build_random_face():
	for body_part_category in get_children():
		var parts = body_part_category.get_children()
		# hide all
		for body_part in parts:
			body_part.visible = false
		# show one
		parts[randi()%parts.size()-1].visible = true




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

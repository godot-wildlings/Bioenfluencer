extends TextureRect

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
var number_followers : int = 500

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

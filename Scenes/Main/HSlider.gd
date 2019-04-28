extends HSlider

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	min_value = 0.0001
	step = 0.0001
	set_volume(value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_volume(ratio : float):
	ratio = clamp(ratio, 0, 1.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), log(ratio) * 20)

func _on_HSlider_value_changed(value):

	set_volume(value)
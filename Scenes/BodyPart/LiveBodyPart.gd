extends Sprite

#warning-ignore:unused_class_variable
var genes : Array = []

#warning-ignore:unused_class_variable
var sale_value : float = 0.0

var value : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_gene(gene):
	genes.push_back(gene)

func add_audio(audio_stream : AudioStream):
	$AudioStreamPlayer.set_stream(audio_stream)

func has_noise():
	if $AudioStreamPlayer.stream != null:
		return true
	else:
		return false

func make_noise():
	if $AudioStreamPlayer.stream != null:
		$AudioStreamPlayer.set_volume_db(rand_range(-12, -5))
		$AudioStreamPlayer.set_pitch_scale(rand_range(0.8, 1.2))
		$AudioStreamPlayer.play()


func get_value() -> float:
	value = 0.0
	if genes.size() > 0:
		for gene in genes:
			value += gene.get_value()
		value /= genes.size() # average, not total
	return value


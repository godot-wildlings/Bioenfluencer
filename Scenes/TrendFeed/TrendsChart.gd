extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("populate_chart")

func populate_chart():
	var trends_list = DataStore.get_gene_list()

	for trend_name in trends_list:
		var trend_line_scene = load("res://Scenes/TrendFeed/SingleTrendLine.tscn")
		var new_trend_line = trend_line_scene.instance()
		var viewing_area = $ReferenceRect.get_rect()
		# order is important. Can't call start before add_child
		$TrendsContainer.add_child(new_trend_line)
		new_trend_line.start(trend_name, viewing_area)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ReturnButton_pressed():
	Game.main._on_AnyButton_pressed()


	Game.main.return_to_main()

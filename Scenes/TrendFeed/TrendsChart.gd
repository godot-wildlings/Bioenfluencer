extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("populate_chart")

func populate_chart():
	var trends_list = DataStore.get_gene_list()
	print(self.name, ": ", trends_list)
	for trend_name in trends_list:
		var trend_line_scene = load("res://Scenes/TrendFeed/SingleTrendLine.tscn")
		var new_trend_line = trend_line_scene.instance()

		new_trend_line.start(trend_name)
		$TrendsContainer.add_child(new_trend_line)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ReturnButton_pressed():
	Game.main.return_to_main()

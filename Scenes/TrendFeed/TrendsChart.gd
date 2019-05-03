extends Control

onready var pay_analyst_button : Button = $InfoPopup/MarginContainer/VBoxContainer/HBoxContainer/PayAnalystButton
onready var info_popup : Button = $InfoPopup

func _ready():
	show_info_popup()
	pay_analyst_button.hide()

	if Game.week > 1:
		call_deferred("populate_chart")

		pay_analyst_button.show()
		if Game.player.blood == 0:
			pay_analyst_button.set_disabled(true)




func show_info_popup():
	$InfoPopup.show()


func populate_chart():

	var trends_list = DataStore.get_gene_list()

	for trend_name in trends_list:
		var trend_line_scene = load("res://Scenes/TrendFeed/SingleTrendLine.tscn")
		var new_trend_line = trend_line_scene.instance()
		var viewing_area = $MarginContainer/ReferenceRect.get_rect()
		# order is important. Can't call start before add_child
		$TrendsContainer.add_child(new_trend_line)
		new_trend_line.start(trend_name, viewing_area)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ReturnButton_pressed():

	Game.main.return_to_main()


func _on_PayAnalystButton_pressed():
	Game.player.blood = max(0, Game.player.blood - 1)
	info_popup.hide()


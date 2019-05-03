"""
Generate some random trends.
Populate a grid with random letters,
replace a few letters to show some trending words.

Each trend needs a slope : float (x/y)
	to indicate whether it's on the rise or wane.


"""

extends Control


var trends = DataStore.get_gene_list()


#var trends = creature_colors + body_shapes + creature_movement
onready var active_trends : Dictionary = {}

onready var grid : TileMap = $TrendFeed1/Panel/WordGrid
onready var grid_size : Vector2 = grid.get_cell_size()
onready var caret : Position2D = $TrendFeed1/Panel/WordGrid/caret
onready var letters_container = $TrendFeed1/Panel/WordGrid/Letters
onready var trending_gene_label = $TrendFeed1/Panel/VBoxContainer/TrendingGene
onready var analyst_button = $TrendFeed1/Panel/VBoxContainer/HBoxContainer/AnalystButton
onready var grid_rows : int
onready var grid_cols : int
onready var grid_offset = $TrendFeed1/Panel/WordGrid/UpperLeft.position
onready var visible_area : Rect2 = Rect2(grid_offset, $TrendFeed1/Panel/WordGrid/BottomRight.position - grid_offset)

onready var falling_letter = preload("res://Scenes/TrendFeed/FallingLetter.tscn")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var gene : Gene = DataStore.get_gene(creature_colors[3])

	randomize()
	setup_grid()
	populate_field(visible_area)
	generate_trending_words(5)
	display_trends(5)

	setup_buttons()

func setup_buttons() -> void:
	analyst_button.set_tooltip("Paying an analyst will cost you blood.")
	if Game.player.blood <= 0:
			#Game.main.return_to_main()
			analyst_button.set_disabled(true)



func setup_grid():
	grid_rows = int(visible_area.size.y / grid_size.y)
	grid_cols = int(visible_area.size.x / grid_size.x)

func generate_trending_words(num_trends_active : int) -> void:
	#warning-ignore:unused_variable
	for i in range(num_trends_active):
		var word = get_random_trend()
		#active_trends[word] = get_random_trending_rate()

		# change this to track number of followers instead of trending factor
		#active_trends[word] = DataStore.get_gene(word).trending_factor
		var num_followers = DataStore.get_gene(word).number_of_followers
		var num_digits = log(num_followers)/log(10)
		print(self.name, "word == ", word, ", num_followers == ", num_followers, ", num_digits == ", num_digits)
		active_trends[word] = -1*( num_digits - 2.0 )


func display_trends(num_trends_visible : int) -> void:
	var columns = []
	#warning-ignore:unused_variable
	for i in range(grid_cols):
		columns.push_back(i)
	columns.shuffle()


	#warning-ignore:unused_variable
	for i in range(num_trends_visible):
		var word = active_trends.keys()[randi()%active_trends.size()]

		var rand_col = columns.pop_front()
		var rand_row = randi()%(grid_rows - word.length())
		var location = Vector2(grid_offset.x + rand_col*grid_size.x, grid_offset.y + rand_row*grid_size.y)
		insert_word(word, location, Vector2.DOWN )


func get_random_trend() -> String:
	return trends[randi()%trends.size()]

func get_random_trending_rate() -> float:
	return randf()*3.0 + 2.0

func get_random_grid_location(area : Rect2) -> Vector2:
	var tiles : Vector2 = Vector2(area.size.x / grid_size.x, area.size.y / grid_size.y)
	var random_tile = Vector2(randi()%int(tiles.x), randi()%int(tiles.y))
	var random_grid_location = Vector2(random_tile.x * grid_size.x + area.position.x, random_tile.y * grid_size.y + area.position.y)
	return random_grid_location

func populate_field(area : Rect2) -> void:
	var letters = "abcdefghijklmnopqrstuvwxyz"


	caret.position = area.position
	#warning-ignore:unused_variable
	for row in range(area.size.y/grid_size.y):
		#warning-ignore:unused_variable
		for col in range(area.size.x/grid_size.x):
			var new_falling_letter = falling_letter.instance()
			new_falling_letter.set_mouse_filter(MOUSE_FILTER_IGNORE)
			new_falling_letter.set_text(letters.substr(randi()%letters.length(), 1))
			#new_falling_letter.set_self_modulate(Color.darkgreen)
			#new_falling_letter.set_text(".")
			letters_container.add_child(new_falling_letter)
			new_falling_letter.set_position(caret.position)
			new_falling_letter.screen_area = visible_area
			new_falling_letter.name = str(floor(caret.position.x/grid_size.x)) + "x" + str(floor(caret.position.y/grid_size.y))
			caret.position.x += grid_size.x
		caret.position.x = area.position.x
		caret.position.y += grid_size.y

func insert_word(word : String, location : Vector2, direction : Vector2):

	caret.position = location
	#warning-ignore:unused_variable

	for i in range(word.length()):
		var node_name = str(int((caret.position.x)/grid_size.x)) + "x" + str(int(caret.position.y/grid_size.y))

		var letter = word.substr(i, 1)

		if letters_container.has_node(node_name):
			var falling_letter = letters_container.get_node(node_name)
			falling_letter.set_text(letter)
			falling_letter.set_mouse_filter(MOUSE_FILTER_STOP)
			# make them the same colour until you mouseover the letters
			#falling_letter.set_self_modulate(Color.darkgreen)
			falling_letter.is_in_trending_word = true

			var movement_speed = active_trends[word]
			falling_letter.set_speed(movement_speed)

		else:
			#push_warning(self.name + ": something wrong with node_name in insert_word()")
			pass

		if direction == Vector2.RIGHT:
			caret.position.x += grid_size.x
		else:
			caret.position.y += grid_size.y


func _on_Timer_timeout():
	for letter in letters_container.get_children():
		letter.drop()


func _on_AnalystButton_pressed():

	var trending_gene_name = DataStore.get_trending_gene().name
	trending_gene_label.set_text("Analyst says: " + trending_gene_name + " is trending.")
	Game.player.blood -= 1
	if Game.player.blood <= 0:
		#Game.main.return_to_main()
		analyst_button.set_disabled(true)

func _on_ReturnToMainButton_pressed():
	Game.main.return_to_main()



func _on_SweatTimer_timeout():
	Game.player.sweat -= 1
	if Game.player.sweat <= 0:
		$EjectionDescription.show()
		$SweatTimer.stop()



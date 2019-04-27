"""
Generate some random trends.
Populate a grid with random letters,
replace a few letters to show some trending words.

Each trend needs a slope : float (x/y)
	to indicate whether it's on the rise or wane.


"""

extends Control

# This will move to the resource Caevv set up
var creature_colors = ["pink", "red", "brown", "blue"]
var body_shapes = ["pudgy", "lean", "pear", "wobbly", "thin", "muscular" ]
var creature_movement = [ "wobbly", "bouncy", "jittery", "calm" ]

var trends = creature_colors + body_shapes + creature_movement
onready var active_trends : Dictionary = {}

onready var grid : TileMap = $TrendFeed1/Panel/WordGrid
onready var grid_size : Vector2 = grid.get_cell_size()
onready var caret : Position2D = $TrendFeed1/Panel/WordGrid/caret
onready var letters_container = $TrendFeed1/Panel/WordGrid/Letters
onready var grid_rows = 32
onready var grid_cols = 32
onready var grid_offset = Vector2(16,16)
onready var visible_area : Rect2 = Rect2(grid_offset, Vector2(grid_cols * grid_size.x, grid_rows * grid_size.y))

onready var falling_letter = preload("res://Scenes/TrendFeed/FallingLetter.tscn")

signal give_trend_letter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var gene : Gene = data_store.get_gene(creature_colors[3])
	print(gene.name)
	
	randomize()

	populate_field(visible_area)

	#warning-ignore:unused_return_value
	self.connect("give_trend_letter", letters_container, "_on_give_trend_letter")

	generate_trending_words(5)
	display_trends(5)



func generate_trending_words(num_trends_active : int) -> void:
	#warning-ignore:unused_variable
	for i in range(num_trends_active):
		var word = get_random_trend()
		active_trends[word] = get_random_trending_rate()


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

			new_falling_letter.set_text(letters.substr(randi()%letters.length(), 1))
			new_falling_letter.set_self_modulate(Color.darkgray)
			#new_falling_letter.set_text(".")
			letters_container.add_child(new_falling_letter)
			new_falling_letter.set_position(caret.position)
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
			falling_letter.set_self_modulate(Color.white)

			var movement_speed = active_trends[word]
			falling_letter.set_speed(movement_speed)

			emit_signal("give_trend_letter",node_name, movement_speed)
		else:
			push_warning(self.name + ": something wrong with node_name in insert_word()")
		if direction == Vector2.RIGHT:
			caret.position.x += grid_size.x
		else:
			caret.position.y += grid_size.y

#warning-ignore:unused_argument
func _process(delta) -> void:
	"""
	The active_trends dictionary holds trend words along with a float value from 0 to 2.0
	The goal is to use the float to indicate how fast the letters should move down the page.
	Faster letters are more trendy, therefore those qualities should be more valuable.
	"""
	#streaming letters is not yet implemented
	pass

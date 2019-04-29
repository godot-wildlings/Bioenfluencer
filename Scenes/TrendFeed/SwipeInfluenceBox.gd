"""
Generate a story based on current trends.

Show the player a button they can click to influence trends.

"""

extends Panel

onready var influencer_icon_container = $VBoxContainer/InfluencerIcon
var influencer_scene = preload("res://Scenes/NPCs/Influencer.tscn")
onready var text_box = $VBoxContainer/RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	call_deferred("start")

func start():
	var new_influencer = influencer_scene.instance()
	influencer_icon_container.add_child(new_influencer)
	new_influencer.start("display")

	update_text(new_influencer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_random_location():
	var locations = [
			"Grand Pier",
			"Wicked Cathedral",
			"Multiversives",
			"Picture Purrfect"
	 ]

	return locations[randi()%locations.size()]

func get_random_story():
	# can we create an event with two influencers together?

	var stories = [
		"<influencer> was spotted at <location>, with <gender> newest creature.\n<trends> <trend_performance>",
		"Here at <location>, <influencer> likes to show off <gender> <trends> creatures."
	]

	return stories[randi()%stories.size()]


func get_trend_performance(influencer):
	"""a text story showing whether the trends will rise or fall, based on who the influencer is (ie: number of followers)"""

	var positive_stories = [
		"are so hot right now",
		"are on the rise",
		"will surely be next years trends"
	]

	if influencer.number_followers > 200:
		return positive_stories[randi()%positive_stories.size()]
	elif influencer.number_followers < 100:
		return "are so yesterday!"
	else:
		return "are still big"

func get_trends():
	# **** TBD
	# get three random trends from the DataStore, or grab trends with specific performance characteristics based on the influencer
	var trends : String = ""
	for i in range(3):
		trends += DataStore.get_random_gene().name
		if i < 2:
			trends += ", "
	return trends

func update_text(influencer_node):
	var influencer_name = influencer_node.influencer_name
	var location_name = get_random_location()
	var trend_performance = get_trend_performance(influencer_node)
	var trends = get_trends()

	var story = get_random_story()
	story = story.replace("<influencer>", influencer_name)
	story = story.replace("<location>", location_name)
	story = story.replace("<trends>", trends)
	story = story.replace("<gender>", influencer_node.gender)
	story = story.replace("<trend_performance>", trend_performance)
	text_box.set_bbcode(story)

func _on_ChooseStory_pressed():
	"""
		Get a list of the trends in the story, and how they're likely to change.
		Tell DataStore that trends are changing.

	"""
	print("chose a story")
	Game.main.return_to_main()

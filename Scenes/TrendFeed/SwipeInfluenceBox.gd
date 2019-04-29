"""
Generate a story based on current trends.

Show the player a button they can click to influence trends.

"""

extends Panel

onready var influencer_icon_container = $VBoxContainer/InfluencerIcon
var influencer_scene = preload("res://Scenes/NPCs/Influencer.tscn")
onready var text_box = $VBoxContainer/RichTextLabel
var trends_shown_on_card : Array = [] # array contains node references to Gene.tscn objects
var trend_text_on_card : String

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

func get_trends() -> String:
	# get three random trends from the DataStore, or grab trends with specific performance characteristics based on the influencer
	var trend_text : String = ""

	#warning-ignore:unused_variable
	for i in range(3):
		var random_gene = DataStore.get_random_gene()
		if not trends_shown_on_card.has(random_gene):
			trends_shown_on_card.push_back(random_gene)
	#warning-ignore:unused_variable
	for i in range(trends_shown_on_card.size()):
		trend_text += trends_shown_on_card[i].name
		if i < trends_shown_on_card.size()-1:
			trend_text += ", "
	return trend_text

func update_text(influencer_node):
	var influencer_name = influencer_node.influencer_name
	var location_name = get_random_location()
	var trend_performance = get_trend_performance(influencer_node)
	trend_text_on_card = get_trends()

	var story = get_random_story()
	story = story.replace("<influencer>", influencer_name)
	story = story.replace("<location>", location_name)
	story = story.replace("<trends>", trend_text_on_card)
	story = story.replace("<gender>", influencer_node.gender)
	story = story.replace("<trend_performance>", trend_performance)
	text_box.set_bbcode(story)

func _on_ChooseStory_pressed():
	"""
		Get a list of the trends in the story.
		Give those trends more followers
	"""
	Game.main._on_AnyButton_pressed()


	var message: String = ""
	message += "You broadcasted this important bit of news to the world. "
	message += trend_text_on_card
	message += " are on the rise!"


	for trend in trends_shown_on_card:
		var new_followers : int = int(float(Game.player.followers) * rand_range(0.2, 0.8))

		trend.increase_followers(new_followers)
		message += "\n\t" + trend.name + " is up " +  str(new_followers) + " followers."

	$PopupDialog.show()
	$PopupDialog/MarginContainer/VBoxContainer/ChirpOutcomeText.set_text(message)

	Game.player.tears += 20
	#Game.main.return_to_main()


func _on_ReturnToMainButton_pressed():
	Game.main._on_AnyButton_pressed()

	Game.main.return_to_main()

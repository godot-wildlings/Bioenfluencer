extends Control

onready var buy_button : Button = $HBoxContainer/PanelRight/BuyButton
onready var followers_label : Label = $HBoxContainer/PanelLeft/FollowersLabel
onready var cost_label : Label = $HBoxContainer/PanelRight/CostLabel
onready var body_parts : ItemList = $HBoxContainer/VBoxContainer/TabContainer/Store

func _ready() -> void:
	Game.store = self
	call_deferred("_deferred_ready")

func _deferred_ready() -> void:
	#warning-ignore:return_value_discarded
	buy_button.connect("pressed", self, "on_BuyButton_pressed")
	followers_label.text = "Followers : " + str(Game.player.followers)
	#warning-ignore:return_value_discarded
	Game.player.connect("player_followers_changed", self, "on_PlayerBioenfluencer_player_followers_changed")

func _on_ReturnToMainButton_pressed() -> void:
	Game.main.return_to_main()

func _process(delta : float) -> void:
	if body_parts.selected_body_part == null or not is_instance_valid(body_parts.selected_body_part):
		buy_button.disabled = true

func on_BuyButton_pressed() -> void:
	if Game.player.followers - body_parts.selected_body_part.price >= 0:
		if is_instance_valid(body_parts.selected_body_part):
			Game.player.followers -= body_parts.selected_body_part.price
			DataStore.unlock_new_body_part(body_parts.selected_body_part)
			var selected_items : PoolIntArray = body_parts.get_selected_items()
			body_parts.remove_item(selected_items[0])
			buy_button.disabled = true
			cost_label.text = "Cost: "

func on_BodyParts_selection_change(selection : BodyPart) -> void:
	if is_instance_valid(selection):
		cost_label.text = "Cost: " + str(selection.price)
		if Game.player.followers - body_parts.selected_body_part.price < 0:
			buy_button.disabled = true
		else:
			buy_button.disabled = false

func on_PlayerBioenfluencer_player_followers_changed(followers : int) -> void:
	followers_label.text = "Followers: " + str(followers)
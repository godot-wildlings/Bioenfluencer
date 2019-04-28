extends Control

onready var buy_button : Button = $HBoxContainer/PanelRight/BuyButton
onready var money_label : Label = $HBoxContainer/PanelLeft/MoneyLabel
onready var cost_label : Label = $HBoxContainer/PanelRight/CostLabel
onready var body_parts : ItemList = $HBoxContainer/VBoxContainer/TabContainer/Tab1/BodyParts


func _ready() -> void:
	Game.store = self


func _on_ReturnToMainButton_pressed() -> void:
	Game.main.return_to_main()

func _on_BodyParts_selection_change(selection : BodyPart) -> void:
	if is_instance_valid(selection):
		cost_label.text = "Cost: " + str(selection.price)

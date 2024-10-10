class_name overworldmap
extends Control

@onready var race_select = $race_select as Button
@onready var store_screen = $store_screen as Button
@onready var back_button = $back_button as Button

#putangina mo gumana ka hayop first time ko mag code mag isa walang turorial fully
func _ready():
	race_select.button_down.connect(on_race_select_pressed)
	store_screen.button_down.connect(on_store_screen_pressed)
	back_button.button_down.connect(on_back_button_pressed)

func on_race_select_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	pass

func on_store_screen_pressed() -> void:
	pass

func on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


  

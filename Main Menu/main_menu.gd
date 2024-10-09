class_name mainmenu
extends Control

@onready var play_button = $MarginContainer/HBoxContainer/VBoxContainer/play_button as Button
@onready var options_button = $MarginContainer/HBoxContainer/VBoxContainer/options_button as Button
@onready var credits_button = $MarginContainer/HBoxContainer/VBoxContainer/credits_button as Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/exit_button as Button
@onready var overworld_map = preload("res://Overworld Map/Overworld Map.tscn") as PackedScene
@onready var options_screen = preload("res://Options Screen/options.tscn") as PackedScene
@onready var credits_screen = preload("res://Credits/credits1.tscn") as PackedScene


func _ready():
	play_button.button_down.connect(on_play_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	credits_button.button_down.connect(on_credits_pressed)
	options_button.button_down.connect(on_options_pressed)
	self.add_to_group("menu_group")

func on_play_pressed() -> void:
	get_tree().change_scene_to_packed(overworld_map)

func on_exit_pressed() -> void:
	get_tree().quit()

func on_credits_pressed() -> void:
	get_tree().change_scene_to_packed(credits_screen)

func on_options_pressed() -> void:
	get_tree().change_scene_to_packed(options_screen)


class_name credit1
extends Control

func _ready():
	pass

func on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

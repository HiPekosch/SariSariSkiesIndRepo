class_name credit1
extends Control

func _ready():
	pass

func on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menu/main_menu.tscn")

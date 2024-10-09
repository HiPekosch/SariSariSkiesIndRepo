class_name credit2
extends Control

@onready var credit_next_button = $credit_next as Button
@onready var credit_next_screen = preload("res://Credits/credits_next.tscn") as PackedScene

func on_credit_next_pressed():
	get_tree().change_scene_to_packed(credit_next_screen)

extends Node2D

@onready var hud: CanvasLayer = $Hud

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")

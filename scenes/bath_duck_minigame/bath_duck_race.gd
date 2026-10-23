extends Node2D

@onready var hud: CanvasLayer = $Hud

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

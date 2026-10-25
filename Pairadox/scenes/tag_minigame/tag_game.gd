extends Node2D

@onready var speed_potion: Area2D = $SpeedPotion
@onready var speed_potion_2: Area2D = $SpeedPotion2
@onready var victory_screen: Control = $VictoryScreen

func _ready() -> void:
	victory_screen.visible = false

func _on_potion_timer_timeout() -> void:
	speed_potion.visible = true

func _on_potion_timer_2_timeout() -> void:
	speed_potion_2.visible = true

func _on_resume_pressed() -> void:
	get_tree().call_deferred("reload_current_scene")

func _on_quit_pressed() -> void:
	queue_free()

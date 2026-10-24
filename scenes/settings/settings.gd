extends Control

@onready var back = $back
@onready var fullscreen = $buttons/fullscreen
@onready var audio = $buttons/audio

var audio_on := true

func _ready() -> void:
	back.pressed.connect(_on_back)
	audio.pressed.connect(_on_audio_pressed)
	fullscreen.pressed.connect(_on_fullscreen_pressed)

func _on_fullscreen_pressed():
	var mode = DisplayServer.window_get_mode()
	if mode == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
func _on_audio_pressed():
	if audio_on:
		AudioServer.set_bus_mute(0,true)
		audio_on = false
	else:
		AudioServer.set_bus_mute(0,false)
		audio_on = true
	audio.text = "AUDIO "+ ("ON" if audio_on else "OFF")

func _on_back():
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")

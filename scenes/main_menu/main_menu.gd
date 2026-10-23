extends Control

@onready var buttons :Array[Button] = [$start,$settings]
var toggler = two_button_toggler.new()
func _ready():
	add_child(toggler)
	buttons[0].pressed.connect(_on_start)
	buttons[1].pressed.connect(_settings)

func _process(_delta:float):
	if ["down_1","down_2","left_1","left_2","up_1","up_2","right_1","right_2"].any(Input.is_action_just_pressed):
		toggler.toggle($start,$settings)
func _on_start():
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")
func _settings():
	get_tree().change_scene_to_file("res://scenes/settings/settings.tscn")

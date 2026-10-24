extends Control

@onready var normal := $VSplitContainer/normal
@onready var ultimate := $VSplitContainer/ultimate

var toggler = two_button_toggler.new()

func _ready():
	add_child(toggler)
	normal.pressed.connect(_on_normal_pressed)
	ultimate.pressed.connect(_on_ultimate_pressed)

func _process(_delta:float):
	if ["down_1","down_2","up_1","up_2","left_1","left_2","right_1","right_2"].any(Input.is_action_just_pressed):
		toggler.switch(normal,ultimate)

func _on_normal_pressed():
	Globals.switch_to_scene("tictactoe/normal.tscn")

func _on_ultimate_pressed():
	Globals.switch_to_scene("tictactoe/ultimate.tscn")

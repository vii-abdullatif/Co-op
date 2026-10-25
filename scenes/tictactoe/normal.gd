extends Control

@onready var x = $canvas/X
@onready var o = $canvas/O
@onready var base = $canvas/Base
@onready var restart_btn = $canvas/restart
@onready var score = $canvas/score

var x_score := 0
var o_score := 0

func _ready():
	restart_btn.pressed.connect(_on_restart_pressed)
	base.finished.connect(_on_base_finished)
	base.turn_changed.connect(_on_turn_changed)

func _on_restart_pressed():
	base.restart()

func _on_base_finished(result:String):
	if result == "x":
		x_score += 1
	elif result == "o":
		o_score += 1
	score.text = str(x_score) + " VS " + str(o_score)

func _on_turn_changed(turn:String):
	x.visible = turn == "x"
	o.visible = turn == "o"

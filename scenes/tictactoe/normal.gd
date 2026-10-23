extends Control

@onready var x = $canvas/X
@onready var o = $canvas/O
@onready var restart_btn = $restart
var turn = "x"

var cells := [
	# Row 1
	{"occupied":"","pos":Vector2i(350,130)},
	{"occupied":"","pos":Vector2i(630,130)},
	{"occupied":"","pos":Vector2i(925,130)},
	
	# Row 2
	{"occupied":"","pos":Vector2i(350,340)},
	{"occupied":"","pos":Vector2i(630,340)},
	{"occupied":"","pos":Vector2i(925,340)},
	
	# Row 3
	{"occupied":"","pos":Vector2i(350,550)},
	{"occupied":"","pos":Vector2i(630,550)},
	{"occupied":"","pos":Vector2i(925,550)},
	
]

func _ready():
	restart_btn.pressed.connect(_on_restart_pressed)


func _process(_delta:float):
	x.visible = turn=="x"
	o.visible = turn == "o"

func _on_restart_pressed():
	restart()
func restart():
	

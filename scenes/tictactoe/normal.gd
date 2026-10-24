extends Control

const LINES = [
	
	# Horizontal
	[0,1,2],[3,4,5],[6,7,8],
	
	# Vertical
	[0,3,6],[1,4,7],[2,5,8],

	# Diagonal
	[0,4,8],[2,4,6]
]

@onready var score :Label = $score
@onready var x = $canvas/X
@onready var o = $canvas/O
@onready var restart_btn = $restart
var turn = "x"
var x_score := 0
var o_score := 0
var textures = {
	"x":preload("res://assets/x-tic.png"),
	"o":preload("res://assets/o.png")
}

var buttons = []
var board = []
#var cells := [
	## Row 1
	#{"occupied":"","pos":Vector2i(350,130)},
	#{"occupied":"","pos":Vector2i(630,130)},
	#{"occupied":"","pos":Vector2i(925,130)},
	#
	## Row 2
	#{"occupied":"","pos":Vector2i(350,340)},
	#{"occupied":"","pos":Vector2i(630,340)},
	#{"occupied":"","pos":Vector2i(925,340)},
	#
	## Row 3
	#{"occupied":"","pos":Vector2i(350,550)},
	#{"occupied":"","pos":Vector2i(630,550)},
	#{"occupied":"","pos":Vector2i(925,550)},
	#
#]

func _ready():
	restart_btn.pressed.connect(_on_restart_pressed)
	for i in 9:
		var btn := find_child(str(i),true,false) as Button
		if btn == null:
			return
		buttons.append(btn)
		btn.pressed.connect(_on_btn_pressed.bind(i))
	restart()

func _process(_delta:float):
	score.text = str(x_score) + " VS " + str(o_score)
	x.visible = turn=="x"
	o.visible = turn == "o"

func _on_restart_pressed():
	restart()
func restart():
	for btn in buttons:
		btn.disabled = false
		btn.icon = Texture.new()
	board = []
	for i in 9:
		board.push_back("")

func _on_btn_pressed(index:int):
	board[index] = turn
	buttons[index].icon = textures[turn]
	buttons[index].disabled = true
	check_result()
	turn = "o" if turn == "x" else "x"

func check_result():
	for line in LINES:
		var a:String = board[line[0]]
		if a != "" and a== board[line[1]] and  a == board[line[2]]:
			if a=="x":
				x_score+=1
			else:
				o_score+=1
			restart()
	if not board.has(""):
		await get_tree().create_timer(1.5).timeout
		restart()

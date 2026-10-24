extends Control

signal finished(result:String)

@export var turn = "x"
var x_score := 0
var o_score := 0
var textures = {
	"x":preload("res://assets/x-tic.png"),
	"o":preload("res://assets/o.png")
}

var buttons = []
var board = []

func _ready():
	for i in 9:
		var btn := find_child(str(i),true,false) as Button
		if btn == null:
			return
		buttons.append(btn)
		btn.pressed.connect(_on_btn_pressed.bind(i))
	restart()

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
	var result = tictactoeLogic.check_result(board)
	if result != "":
		if result == "x":
			x_score += 1
		elif result == "o":
			o_score += 1
		finished.emit(result)
		await get_tree().create_timer(1).timeout
		restart()
		
	turn = "o" if turn == "x" else "x"

func start(first:String):
	restart()
	turn = first

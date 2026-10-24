extends Control

signal finished(result:String)
signal turn_changed(turn:String)
@export var turn = "x"
@export var auto_restart := true
var textures = {
	"x":preload("res://assets/x-tic.png"),
	"o":preload("res://assets/o.png")
}

var buttons = []
var board = []
var game_over := false

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
	if game_over or board[index] != "":
		return
	board[index] = turn
	buttons[index].icon = textures[turn]
	buttons[index].disabled = true
	var result = tictactoeLogic.check_result(board)
	if result != "":
		game_over = true
		finished.emit(result)
		if auto_restart:
			await get_tree().create_timer(1).timeout
			restart()
		return
	turn = "o" if turn == "x" else "x"
	turn_changed.emit(turn)

func start(first:String):
	restart()
	turn = first
	turn_changed.emit(turn)

func set_locked(locked:bool):
	for btn in buttons:
		btn.mouse_filter = Control.MOUSE_FILTER_IGNORE if locked else Control.MOUSE_FILTER_STOP

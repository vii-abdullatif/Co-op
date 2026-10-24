extends Control

const mini_scene = preload("res://scenes/tictactoe/base.tscn")
const mini_cell_size = Vector2(300,200)
const design_size = Vector2(1280,720)

@onready var grid = $GridContainer
@onready var score = $score
@onready var mini_indicator = $miniIndicator

var textures = {
	"x":load("res://assets/x-tic.png"),
	"o":load("res://assets/o.png")
}

var big_board:Array[String] = []

var active_cell = -1
var picker = "x"
var mini_first = "o"
var mini_turn = "o"
var game_done = false

func _ready():
	for i in 9:
		var slot = grid.get_node(str(i))
		slot.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		
		var mini_instantiate = mini_scene.instantiate()
		slot.add_child(mini_instantiate)
		mini_instantiate.name = "mini"
		mini_instantiate.size = design_size
		mini_instantiate.scale = mini_cell_size / design_size
		mini_instantiate.auto_restart = true
		mini_instantiate.mouse_filter = Control.MOUSE_FILTER_IGNORE
		
		slot.pressed.connect(_on_pick.bind(i))
		mini_instantiate.finished.connect(_on_mini_finished)
		mini_instantiate.turn_changed.connect(_on_mini_turn_changed)
		
	new_match()

func _on_mini_finished(result:String):
	var i = active_cell
	if i == -1:
		return
	var mini = _get_part(i,"mini")
	await get_tree().create_timer(1).timeout
	if result == "draw":
		mini_first = flip_turn(mini_first)
		mini.start(mini_first)
		return
	big_board[i] = result
	_get_slot(i).icon = textures[result]
	mini.hide()
	mini.set_locked(true)
	active_cell = -1
	
	if tictactoeLogic.check_result(big_board) != "":
		game_done = true
	else:
		picker = flip_turn(picker)
	update_ui()
func _on_pick(index:int):
	if game_done or active_cell != -1 or big_board[index] != "":
		return
	active_cell = index
	mini_first = flip_turn(picker)
	mini_turn = mini_first
	var mini = _get_part(index,"mini")
	mini.set_locked(false)
	mini.start(mini_first)
	update_ui()
	

func new_match():
	picker = "x"
	mini_turn = "o"
	active_cell = -1
	game_done = false
	big_board.clear()
	big_board.resize(9)
	big_board.fill("")
	for i in 9:
		_get_slot(i).icon = null
		var mini = _get_part(i,"mini")
		mini.show()
		mini.restart()
		mini.set_locked(true)
	update_ui()

func update_ui():
	for i in 9:
		_get_slot(i).modulate.a = 1.0 if (active_cell == -1 or i == active_cell) else 0.5
	var current = mini_turn if active_cell == -1 else picker
	

func _get_slot(i:int)->Control:
	return grid.get_node(str(i))

func _get_part(i:int,part:String)->Node:
	return _get_slot(i).get_node(part)

func flip_turn(p:String)->String:
	return "o" if p =="x" else "x"

func _on_mini_turn_changed(new_turn:String):
	mini_turn = new_turn
	update_ui()

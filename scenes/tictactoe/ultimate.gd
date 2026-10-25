extends Control

# Get base scene in order to instantiate 9 times
const mini_scene = preload("res://scenes/tictactoe/base.tscn")

# Dimensions of base.tscn
const design_size = Vector2(800,600)

# Main Grid, score and canvases
@onready var grid = $canvas/GridContainer
@onready var score = $canvas/score
@onready var x = $canvas/X
@onready var o = $canvas/O
@onready var audio = $audioplayer

# Load textures for strokes
var textures = {
	"x":load("res://assets/x-tic.png"),
	"o":load("res://assets/o.png")
}

# Big result and score
var big_board:Array[String] = []
var x_score := 0
var o_score := 0

var active_cell = -1
# Picker of the big cell
var picker = "x"
# First player in the big cell
var mini_first = "o"
# Current turn inside the big cell
var mini_turn = "o"
# Big game done
var game_done = false

func _ready():
	audio.play()
	# Insantiate the grid 9 times
	for i in 9:
		# Slot -> Big box to place base.tscn inside
		var slot = grid.get_node(str(i))
		# Modify texture filter
		slot.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		# Instantiate, add, rescale, and enable autostart
		var mini_instantiate = mini_scene.instantiate()
		slot.add_child(mini_instantiate)
		mini_instantiate.name = "mini"
		# Used claude for assistance with diemsnions and scaling management
		mini_instantiate.size = design_size
		mini_instantiate.scale = Vector2(0.3,0.3)
		mini_instantiate.position = Vector2(13,10)
		
		mini_instantiate.auto_restart = true
		mini_instantiate.mouse_filter = Control.MOUSE_FILTER_IGNORE
		
		# Listen for signals
		slot.pressed.connect(_on_pick.bind(i))
		mini_instantiate.finished.connect(_on_mini_finished)
		mini_instantiate.turn_changed.connect(_on_mini_turn_changed)
	
	# Start new match
	new_match()

func _on_mini_finished(result:String):
	
	var i = active_cell
	if i == -1:
		return
	var mini_part= _get_part(i,"mini")
	await get_tree().create_timer(1).timeout
	if result == "draw":
		mini_first = flip_turn(mini_first)
		mini_part.start(mini_first)
		return
	big_board[i] = result
	_get_slot(i).icon = textures[result]
	mini_part.hide()
	mini_part.set_locked(true)
	active_cell = -1
	var big_result = tictactoeLogic.check_result(big_board)
	if big_result != "":
		game_done = true
		if big_result == "x":
			x_score += 1
		elif big_result == "o":
			o_score+=1
		new_match()
	else:
		picker = flip_turn(picker)
	update_ui()

func _on_pick(index:int):
	# ignore if game done
	if game_done or active_cell != -1 or big_board[index] != "":
		return
	# Flip turns
	active_cell = index
	mini_first = flip_turn(picker)
	mini_turn = mini_first
	# Lock the mini part 
	var mini_part = _get_part(index,"mini")
	mini_part.set_locked(false)
	mini_part.start(mini_first)
	update_ui()
	

func new_match():
	# Reset variables, clear board, and start
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
	# Update ui thru making some cells darkened and others unfocused
	for i in 9:
		_get_slot(i).modulate.a = 1.0 if (active_cell == -1 or i == active_cell) else 0.5

# Get slot, aka big cell
func _get_slot(i:int)->Control:
	return grid.get_node(str(i))

# Get part of slot, aka slot inside slot :sob:
func _get_part(i:int,part:String)->Node:
	return _get_slot(i).get_node(part)

# Js flip turns :P
func flip_turn(p:String)->String:
	return "o" if p =="x" else "x"

#  manage turns when the turn inside slot changes
func _on_mini_turn_changed(new_turn:String):
	mini_turn = new_turn
	x.visible = mini_turn == "x"
	o.visible = mini_turn == "o"
	update_ui()

# Update score
func _process(_delta:float):
	$canvas/score.text = str(x_score) + " VS " + str(o_score)

extends Control

signal finished(result:String)
signal turn_changed(turn:String)

@export var turn = "x"
@export var auto_restart := true

var game_over = false
var textures = {
	"x":preload("res://assets/x-tic.png"),
	"o":preload("res://assets/o.png")
}
# Buttons and current state of board
var buttons = []
var board = []

func _ready():
	# Get buttons and listen to when pressed
	for i in 9:
		var btn := find_child(str(i),true,false) as Button
		if btn == null:
			return
		buttons.append(btn)
		btn.pressed.connect(_on_btn_pressed.bind(i))
	# Start match by restarting state
	restart()

func _on_restart_pressed():
	restart()

func restart():
	# Restart btns texture and board array
	game_over = false
	for btn in buttons:
		btn.disabled = false
		btn.icon = Texture.new()
	board = []
	for i in 9:
		board.push_back("")

func _on_btn_pressed(index:int):
	# Ignore if game done or paused
	if game_over or board[index] != "":
		return
	# Update current board to check winner
	board[index] = turn
	# Disable button coz already used
	buttons[index].icon = textures[turn]
	buttons[index].disabled = true
	var result = tictactoeLogic.check_result(board)
	if result != "":
		game_over = true
		finished.emit(result)
		if auto_restart:
			# Auto restart after 1 second
			await get_tree().create_timer(1).timeout # So players can see the current board
			restart()
			turn_changed.emit(turn)
		return
	# Flip turns
	turn = "o" if turn == "x" else "x"
	turn_changed.emit(turn)

# Start thru restarting :P
func start(first:String):
	restart()
	turn = first
	turn_changed.emit(turn)

# Lock buttons
func set_locked(locked:bool):
	for btn in buttons:
		btn.mouse_filter = Control.MOUSE_FILTER_IGNORE if locked else Control.MOUSE_FILTER_STOP

extends Control

const mini_scene = preload("res://scenes/tictactoe/normal.tscn")
const mini_cell_size = Vector2(300,200)
const design_size = Vector2(1280,720)

@onready var grid = $GridContainer
@onready var score = $score
@onready var mini_indicator = $miniIndicator

var textures = {
	"x":"res://assets/x_tic.png",
	"o":"res://assets/o.png"
}

var big_board:Array[String] = []

var active_cell = -1
var picker = "x"
var mini_first = "o"

var game_done = false

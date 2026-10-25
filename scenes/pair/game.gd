extends Node

var card_scene = load("res://scenes/pair/card.tscn")
var turn := "Blue"
var blue_score := 0
var red_score := 0
var cards_in_hand := []
var fruit_in_hand = null
@onready var grid = $GridContainer
var fruits = []
# Fruits assets path
const path := "res://assets/fruits"

func get_fruits() -> Array[Texture2D]:
	# Empty to-be-returned array
	var fruits : Array[Texture2D] = []
	
	# Get all folders inside the asset pack
	for folder in DirAccess.get_directories_at(path):
		var dir = path + "/" + folder
		var files := []
		# Get files and choose one random
		for file in DirAccess.get_files_at(dir):
			# Ignore .import files
			var clean := file.trim_suffix(".import")
			if clean.ends_with(".png"):
				files.append(dir+"/"+clean)
		# Pick random png from the folder and append
		fruits.append(load(files.pick_random()))
	
	return fruits

func _ready():
	# Get the 18 fruits
	fruits = get_fruits()
	
	# Double for the memory game
	fruits += fruits
	
	fruits.shuffle()
	
	for i in 36:
		var card = card_scene.instantiate()
		card.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		card.size_flags_vertical = Control.SIZE_EXPAND_FILL
		
		var btn = card.get_node("Card")
		btn.icon = fruits[i]
		btn.pressed.connect(_on_card_pressed.bind(btn,i))
		grid.add_child(card)
	
	await get_tree().create_timer(2).timeout
	for child in grid.get_children():
		child.get_node("Card").icon = null
	
func _on_card_pressed(btn:Button,fruit_num:int):
	btn.icon = fruits[fruit_num]
	cards_in_hand.appedn(fruit_num)
	if card_in_hands == 2:
		if fruits[fruit_num] == fruit_in_hand:
			if turn == "Blue":
				blue_score += 1
			else:
				red_score += 1
		else:
			

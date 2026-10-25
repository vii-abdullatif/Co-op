extends Node

# Children Nodes
@onready var grid = $GridContainer
@onready var blue_label = $"canvas/1"
@onready var red_label = $"canvas/2"
@onready var turn_label = $Label
@onready var audio = $audioplayer
# Fruits textures
var fruits = []

var card_scene = load("res://scenes/pair/card.tscn")

# Main game states
var turn := "Blue"
var locked := true
var blue_score := 0
var red_score := 0

# Selected button to compare against
var first_btn :Button = null

# Index of fruit chosen in 'fruits' array
var first_index := -1

# Number of matched pairs out of 18
var matched := 0
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
	
	# 36 cards, 18 pairs
	for i in 36:
		# Get scene and expand it
		var card = card_scene.instantiate()
		card.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		card.size_flags_vertical = Control.SIZE_EXPAND_FILL
		
		# Set icon and listen for press
		var btn = card.get_node("Card")
		btn.icon = fruits[i]
		btn.pressed.connect(_on_card_pressed.bind(btn,i))
		
		grid.add_child(card)
	
	# Wait for 2 seconds so players can inspect the cards
	await get_tree().create_timer(2).timeout
	
	# Hide >:)
	for child in grid.get_children():
		child.get_node("Card").icon = null
		
	# Unlock board
	locked = false

func _on_card_pressed(btn:Button,fruit_num:int):
	if locked :
		return
	
	# Play audio, set icon and disable
	audio.play()
	btn.icon = fruits[fruit_num]
	btn.disabled = true
	
	# Assign first card to compare against
	if first_btn == null:
		first_btn = btn
		first_index = fruit_num
		return
	locked = true
	
	if fruits[fruit_num] == fruits[first_index]:
		# Update score if pair got right
		if turn == "Blue":
			blue_score += 1
		else:
			red_score += 1
		matched += 1
	else:
		# Await for one second then reverse
		await get_tree().create_timer(1).timeout
		btn.icon = null
		btn.disabled = false
		first_btn.icon = null
		first_btn.disabled = false
		turn = "Red" if turn == "Blue" else "Blue"
	
	# Reset everything and update ui
	first_btn = null
	first_index = -1
	update_ui()
	if matched == 18:
		locked = true
		return
	locked = false

func update_ui():
	blue_label.text = str(blue_score)
	red_label.text = str(red_score)
	turn_label.text = turn.to_upper()+"'S" + " TURN"

extends Node

var card_scene = load("res://scenes/pair/card.tscn")

@onready var grid = $GridContainer

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
	var fruits = get_fruits()
	
	# Double for the memory game
	fruits += fruits
	
	fruits.shuffle()
	
	

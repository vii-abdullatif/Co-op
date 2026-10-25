extends Node

var card_scene = load("res://scenes/pair/card.tscn")
@onready var grid = $GridContainer
const path := "res://assets/fruits"
const colors = ["red","green","blue"]
func get_fruits() -> Array[Texture2D]:
	var fruits : Array[Texture2D] = []
	for folder in DirAccess.get_directories_at(path):
		var dir = path + "/" + folder
		var files := []
		for file in DirAccess.get_files_at(dir):
			var clean := file.trim_suffix(".import")
			if clean.ends_with(".png"):
				files.append(dir+"/"+clean)
		fruits.append(load(files.pick_random()))
	return fruits

func _ready():
	var fruits = get_fruits()
	fruits += fruits
	fruits.shuffle()
	print(len(fruits))

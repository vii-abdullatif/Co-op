extends Node2D

@onready var textureRect = $canvas/tex

func change_tex(path:String):
	var tex = load(path)
	textureRect.texture = tex

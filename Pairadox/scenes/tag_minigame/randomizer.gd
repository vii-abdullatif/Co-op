extends Node2D

func _enter_tree() -> void:
	ViiGlobals.tag_player_ind = randi_range(1, 2)

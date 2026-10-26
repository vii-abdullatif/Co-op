extends Area2D

var players_inside: Array[Node2D] = []

func _on_body_entered(body: Node2D) -> void:
	print("entered: ", body.name, " | in group: ", body.is_in_group("player"))
	if body.is_in_group("player") and body not in players_inside:
		players_inside.append(body)

func _on_body_exited(body: Node2D) -> void:
	players_inside.erase(body)

func _process(_delta: float) -> void:
	for p in players_inside:
		if Input.is_action_just_pressed(p.interact_action):
			print("pressed: ", p.interact_action)
			get_tree().change_scene_to_file("res://scenes/football_header_minigame/head_ball_game.tscn")
			return

extends Node2D

@onready var player_1: Label = $HUD/Player1
@onready var time: Label = $HUD/Time
@onready var player_2: Label = $HUD/Player2
@onready var football_stop_scene: Control = $FootballStopScene

func _process(_delta: float) -> void:
	player_1.text = "Player 1 Goals: " + str(ViiGlobals.football_game_p2)
	player_2.text = "Player 2 Goals: " + str(ViiGlobals.football_game_p1)
	if Input.is_action_just_pressed("escape"):
		get_tree().paused = true
		football_stop_scene.visible = true

func _on_player_1_goal_2_body_entered(body: Node2D) -> void:
		if body.is_in_group("ball"):
			get_tree().call_deferred("reload_current_scene")
			ViiGlobals.football_game_p1 += 1

func _on_player_2_goal_body_entered(body: Node2D) -> void:
		if body.is_in_group("ball"):
			get_tree().call_deferred("reload_current_scene")
			ViiGlobals.football_game_p2 += 1

func _on_resume_pressed() -> void:
	get_tree().paused = false
	football_stop_scene.visible = false

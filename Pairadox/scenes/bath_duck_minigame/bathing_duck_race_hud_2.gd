extends Control

@onready var player_2_score: Label = $Player1Score

func _process(_delta: float) -> void:
	player_2_score.text = "Player 2 score : " + str(ViiGlobals.bathing_duck_race_p2)

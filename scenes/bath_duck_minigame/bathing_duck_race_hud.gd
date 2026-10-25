extends Control

@onready var player_1_score: Label = $Player1Score

func _process(_delta: float) -> void:
	player_1_score.text = "Player 1 score :" + str(ViiGlobals.bathing_duck_race_p1)

extends CharacterBody2D

@onready var bathing_duck_1: CharacterBody2D = $"../BathingDuck1"
@onready var bathing_duck_2: CharacterBody2D = $"../BathingDuck2"

var speed := 10

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("p1_click"):
		bathing_duck_1.position.x += speed
	elif Input.is_action_just_pressed("p2_click"):
		bathing_duck_2.position.x += speed

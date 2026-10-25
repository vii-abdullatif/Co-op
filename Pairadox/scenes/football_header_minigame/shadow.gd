extends Sprite2D

@export var ground_y: float = 540

func _process(_delta: float) -> void:
	var ball := get_parent()
	global_position.x = ball.global_position.x
	global_position.y = ground_y

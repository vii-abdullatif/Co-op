extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var speed := 300.0
var facing_right := true

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("left_1", "right_1", "up_1", "down_1")
	velocity = direction * speed
	if direction.x > 0:
		facing_right = true
		animated_sprite_2d.play("walking_right")
	elif direction.x < 0:
		facing_right = false
		animated_sprite_2d.play("walking_left")
	else:
		if facing_right:
			animated_sprite_2d.play("idle_right")
		else:
			animated_sprite_2d.play("idle_left")
	move_and_slide()

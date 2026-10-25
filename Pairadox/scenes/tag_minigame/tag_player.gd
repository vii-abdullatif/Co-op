extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var speed := 300.0
var facing_right := true

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("left_" + str(ViiGlobals.tag_player_ind), "right_" + str(ViiGlobals.tag_player_ind), "up_" + str(ViiGlobals.tag_player_ind), "down_" + str(ViiGlobals.tag_player_ind))
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

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("buff"):
		speed += 100
		area.queue_free()

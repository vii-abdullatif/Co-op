extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
const SPEED = 300.0
var direction
@export var interact_action := "interact_2"

func _ready() -> void:
	add_to_group("player")
	sprite.animation = "down"
	sprite.frame = 0
	sprite.stop()

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		play_animation()
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		sprite.frame = 0
		sprite.stop()

	move_and_slide()

func play_animation():
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			sprite.play("right")
		else:
			sprite.play("left")
	else:
		if direction.y > 0:
			sprite.play("down")
		else:
			sprite.play("up")

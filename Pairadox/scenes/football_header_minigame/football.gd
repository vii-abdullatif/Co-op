extends CharacterBody2D

@export var gravity: float = 980.0
@export var bounce_damping: float = 0.8
@export var min_bounce_speed: float = 40.0

func _physics_process(delta: float) -> void:
	bouncing(delta)

func bouncing(delta: float) -> void:
	velocity.y += gravity * delta
	var velocity_before_move := velocity  
	move_and_slide()
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var reflected := velocity_before_move.bounce(collision.get_normal()) * bounce_damping
		if reflected.length() < min_bounce_speed:
			reflected = Vector2.ZERO
		velocity = reflected

func apply_impulse(force: Vector2) -> void:
	velocity += force

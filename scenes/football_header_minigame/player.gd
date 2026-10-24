extends CharacterBody2D

const GRAVITY := 980.0
const JUMP_FORCE := -400.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var speed := 300
var pre_jump_duration := 100
var pre_jump_start_time := 0
var is_pre_jumping := false

func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_finished)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	elif not is_pre_jumping:
		animation_player.play("idle")
	var direction = Input.get_vector("left_1", "right_1", "null", "null")
	velocity.x = direction.x * speed
	if Input.is_action_just_pressed("jump_1") and is_on_floor():
		animation_player.play("pre_jump")
		pre_jump_start_time = Time.get_ticks_msec()
		is_pre_jumping = true
	if is_pre_jumping:
		var elapsed = Time.get_ticks_msec() - pre_jump_start_time
		if elapsed >= pre_jump_duration:
			is_pre_jumping = false
			_on_pre_jump_finished()
	move_and_slide()

func _on_pre_jump_finished() -> void:
	velocity.y = JUMP_FORCE
	animation_player.play("jump")

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "jump":
		animation_player.play("after_jump")

extends CharacterBody2D

const GRAVITY := 980.0
const JUMP_FORCE := -400.0
const KICK_FORCE := Vector2(600, -400)
const HEAD_FORCE := Vector2(400, -500)

@export var player_ind := 0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var head_hitbox: Area2D = $HeadHitbox
@onready var kick_hitbox: Area2D = $KickHitbox

var speed := 300
var pre_jump_duration := 100
var pre_jump_start_time := 0
var is_pre_jumping := false
var pre_kicking_duration := 100
var pre_kicking_start_time := 0
var is_pre_kicking := false
var is_kicking := false

func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_finished)
	head_hitbox.monitoring = false
	kick_hitbox.monitoring = false
	

func _physics_process(delta: float) -> void:
	var player_not_idle = is_pre_jumping or is_pre_kicking or is_kicking
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	elif not player_not_idle:
		animation_player.play("idle")
	var direction = Input.get_vector("left_" + str(player_ind), "right_" + str(player_ind), "null", "null")
	velocity.x = direction.x * speed
	if Input.is_action_just_pressed("jump_" + str(player_ind)) and is_on_floor() and not player_not_idle:
		animation_player.play("pre_jump")
		pre_jump_start_time = Time.get_ticks_msec()
		is_pre_jumping = true
	if is_pre_jumping:
		var elapsed = Time.get_ticks_msec() - pre_jump_start_time
		if elapsed >= pre_jump_duration:
			is_pre_jumping = false
			_on_pre_jump_finished()
	if Input.is_action_just_pressed("shoot_" + str(player_ind)) and is_on_floor() and not player_not_idle:
		animation_player.play("pre_kick")
		pre_kicking_start_time = Time.get_ticks_msec()
		is_pre_kicking = true
	if is_pre_kicking:
		var elapsed_kicking = Time.get_ticks_msec() - pre_kicking_start_time
		if elapsed_kicking >= pre_kicking_duration:
			is_pre_kicking = false
			_on_pre_kicking_finished()

	move_and_slide()

func _on_pre_jump_finished() -> void:
	velocity.y = JUMP_FORCE
	animation_player.play("jump")

func _on_pre_kicking_finished() -> void:
	is_kicking = true
	animation_player.play("kick")
	kick_hitbox.monitoring = true

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "jump":
		animation_player.play("after_jump")
		head_hitbox.monitoring = false
	elif anim_name == "kick":
		is_kicking = false
		kick_hitbox.monitoring = false
		animation_player.play("idle")

func _on_kick_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		var dir = sign(global_position.direction_to(body.global_position).x)
		body.apply_impulse(Vector2(KICK_FORCE.x * dir, KICK_FORCE.y))

func _on_head_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		var dir = sign(global_position.direction_to(body.global_position).x)
		body.apply_impulse(Vector2(HEAD_FORCE.x * dir, HEAD_FORCE.y))

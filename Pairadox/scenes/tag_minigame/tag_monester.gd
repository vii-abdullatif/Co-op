extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var attacking_area: Area2D = $AttackingArea
@onready var collision_shape_2d: CollisionShape2D = $AttackingArea/CollisionShape2D
@onready var victory_screen: Control = $"../VictoryScreen"

var speed := 275.0
var facing_right := true
var is_attacking := false
var monester_ind : int = 0

func _ready() -> void:
	if ViiGlobals.tag_player_ind == 1:
		monester_ind += 2
	elif ViiGlobals.tag_player_ind == 2:
		monester_ind += 1
	animated_sprite_2d.animation_finished.connect(_on_animation_finished)

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("left_" + str(monester_ind), "right_" + str(monester_ind), "up_" + str(monester_ind), "down_" + str(monester_ind))
	velocity = direction * speed

	if Input.is_action_just_pressed("attack_" + str(monester_ind)) and not is_attacking:
		is_attacking = true
		animated_sprite_2d.play("attack_right" if facing_right else "attack_left")
		is_attacking_area_monitoring()
		move_and_slide()
		return

	if is_attacking:
		is_attacking_area_monitoring()
		move_and_slide()
		return

	if direction.x > 0:
		attacking_area.scale.x = 1
		facing_right = true
		animated_sprite_2d.play("walking_right")
	elif direction.x < 0:
		attacking_area.scale.x = -1
		facing_right = false
		animated_sprite_2d.play("walking_left")
	else:
		animated_sprite_2d.play("idle_right" if facing_right else "idle_left")

	is_attacking_area_monitoring()
	move_and_slide()

func _on_animation_finished() -> void:
	if is_attacking:
		is_attacking = false

func is_attacking_area_monitoring() -> void:
	attacking_area.monitoring = is_attacking

func _on_attacking_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("tag_player"):
		get_tree().paused = true
		victory_screen.visible = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("buff"):
		speed += 100
		area.queue_free()

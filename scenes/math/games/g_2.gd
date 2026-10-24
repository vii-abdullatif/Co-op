extends Control
@onready var x_dis: Label = $ColorRect/Label
@onready var y_dis: Label = $ColorRect2/Label
@onready var x_sub: Button = $Button2
@onready var y_sub: Button = $Button
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var x: AnimatedSprite2D = $AnimatedSprite2D
@onready var y: AnimatedSprite2D = $AnimatedSprite2D2
var x_ans = 0
var y_ans = 0
var ans = 1
func _ready() -> void:
	x_ans = 0
	y_ans = 0
	x_sub.pressed.connect(x_submit)
	
func _process(delta: float) -> void:
	x_dis.text = str(x_ans)
	y_dis.text = str(y_ans)
	x.animation = "3->2"
	increase()
	
func increase():
	if Input.is_action_just_pressed("right") or Input.is_action_just_pressed("up"):
		x_ans += 1
	elif Input.is_action_just_pressed("down") or Input.is_action_just_pressed("left"):
		x_ans -= 1
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_right"):
		y_ans += 1
	elif Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_left"):
		y_ans -= 1
		
func x_submit():
	if x_ans == ans:
		audio.stream = load("res://assets/SFX/correct.mp3")
		audio.play()
		await audio.finished
		audio.stream = load("res://assets/SFX/fortnite-shield-break-sound.mp3")
		audio.play()
		await audio.finished
		get_tree().change_scene_to_file("res://scenes/math/games/g3.tscn")
	else:
		audio.stream = load("res://assets/SFX/ElevenLabs_Red_Hit_Sound_(Bad_Damage)_Tool__Mubert_or_Soundraw_Prompt___Game_damage_sound_effect,_negative_erro.mp3")
		audio.play()
		
func y_submit():
	if y_ans == ans:
		audio.stream = load("res://assets/SFX/correct.mp3")
		audio.play()
		await audio.finished
		

class_name Highway
extends Node2D
signal addLetter

@onready var game_pad: GamePad = get_parent()
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

@export var key_to_press = "space"

@onready var letter_scene = preload("res://Gamepad/letter.tscn")
@onready var word = ""

var speed

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = game_pad.speed

func _process(delta):
	if (timer.is_stopped()):
		animation_player.play("default")
	
func add_score(dist, letter):
	emit_signal("addLetter", dist, letter)

func clicked():
	animation_player.play("click")
	game_pad.click()
	timer.start()
		
func send_letter(letter):
	print(letter)
	var letter_to_send = letter_scene.instantiate()
	letter_to_send.value = letter
	letter_to_send.position = Vector2(0, 1000)
	add_child(letter_to_send)

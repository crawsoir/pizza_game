class_name Highway
extends Node2D
signal addLetter

@onready var game_pad: GamePad = get_parent()
@export var key_to_press = "space"

@onready var letter_scene = preload("res://Gamepad/letter.tscn")
@onready var word = ""

var speed

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = game_pad.speed
	
func add_score(dist, letter):
	emit_signal("addLetter", dist, letter)
	
func send_letter(letter):
	var letter_to_send = letter_scene.instantiate()
	letter_to_send.value = letter
	letter_to_send.position = Vector2(0, 1000)
	add_child(letter_to_send)

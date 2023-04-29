class_name Highway
extends Node2D
signal addLetter

@onready var game_pad: GamePad = get_parent()
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var letters: Node2D = $Letters
@onready var labelNode: Label = $Label

@export var key_to_press = "space"

@onready var letter_scene = preload("res://Gamepad/letter.tscn")

var speed

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = game_pad.speed
	if (key_to_press == "space"):
		labelNode.text = "_"
	else:
		labelNode.text = key_to_press.split("_")[0].to_lower()

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
	var letter_to_send = letter_scene.instantiate()
	letter_to_send.value = letter
	letters.add_child(letter_to_send)

func free_letters():
	var orig_position = letters.position
	letters.queue_free()
	letters = Node2D.new()
	letters.position = orig_position
	add_child(letters)
	
func _world_boundary(body):
	print(body.position)
	body.queue_free()

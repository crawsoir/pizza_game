class_name Highway
extends Node2D
signal changeSusAmount

@export var speed = 100
@export var letter = "m"
@export var key_to_press = "space"
@export var perfect_range = 5
@export var late_range = 30

@export var perfect_score = 30
@export var late_score = 10
@export var very_late_score = -5

@onready var letter_scene = preload("res://Gamepad/letter.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func add_score(dist):
	if (abs(dist) <= perfect_range):
		emit_signal("changeSusAmount", perfect_score)
	elif (abs(dist) <= late_range):
		emit_signal("changeSusAmount", late_score)
	else:
		emit_signal("changeSusAmount", very_late_score)
	sendLetter()
	
func sendLetter():
	var letter_to_send = letter_scene.instantiate()
	letter_to_send.position = Vector2(0, 440)
	add_child(letter_to_send)

func _on_letter_letter_highway_pressed(amount):
	emit_signal("changeSusAmount", amount)

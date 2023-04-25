class_name Highway
extends Node2D
signal changeSusAmount

@export var speed = 100
@export var letter = "m"
@export var key_to_press = "space"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if (event.is_action_pressed(key_to_press)):
		sendLetter()
	
func sendLetter():
	var letterToSend = Letter.new()
	letterToSend.global_position = $Sprite2D.global_position
	add_child(letterToSend)

func _on_letter_letter_highway_pressed(amount):
	emit_signal("changeSusAmount", amount)

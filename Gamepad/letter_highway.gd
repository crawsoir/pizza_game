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

func get_speed():
	return speed
	
func get_letter():
	return letter
	
func get_key_to_press():
	return key_to_press


func _on_letter_letter_highway_pressed(amount):
	emit_signal("changeSusAmount", amount)

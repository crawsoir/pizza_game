class_name Letter
extends CharacterBody2D

@onready var highway: Highway = get_parent().get_parent()
@onready var label: Label = $Display/Label

var value = "m"
var origin = Vector2(0, 0)
var endPoint = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = value
	origin = position
	endPoint = Vector2(self.position.x, highway.position.y - 1000)

func _physics_process(delta):
	position = position.move_toward(endPoint, delta*highway.speed)
	if (global_position.y < 0):
		queue_free()

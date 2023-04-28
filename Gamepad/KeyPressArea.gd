extends Area2D

@onready var highway: Highway = get_parent()

@export var score = 0

var bodies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

	
func _input(event):
	if (event.is_action_pressed(highway.key_to_press) and len(bodies) > 0 and bodies[0] != null):
		var letter: Letter = bodies[0]
		var dist = position.y - letter.position.y
		bodies.remove_at(0)
		letter.queue_free()
		highway.add_score(dist, letter.value)


func _on_body_entered(body):
	bodies.append(body)

extends Area2D

@onready var highway: Highway = get_parent()

@export var score = 0

var bodies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

	
func _input(event):
	if (event.is_action_pressed(highway.key_to_press)):
		highway.clicked()
		if (len(bodies) > 0):
			var letter: Letter = bodies[-1]
			var dist = global_position.y - letter.global_position.y
			bodies.pop_back()
			letter.queue_free()
			highway.add_score(dist, letter.value)


func _on_body_entered(body):
	bodies.append(body)


func _on_body_exited(body):
	if (bodies.size() > 0):
		bodies.remove_at(0)

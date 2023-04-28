extends Area2D

@onready var highway: Highway = get_parent()

@export var score = 0

var bodies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if (event.is_action_pressed(highway.key_to_press) and len(bodies) > 0 and bodies[0] != null):
		var letter: Letter = bodies[0]
		var dist = position.y - letter.position.y
		bodies.remove_at(0)
		letter.queue_free()
		print(dist)
		highway.add_score(dist)


func _on_body_entered(body):
	bodies.append(body)

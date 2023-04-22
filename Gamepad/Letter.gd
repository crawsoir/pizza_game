class_name Letter
extends Node2D

@onready var highway: Highway = get_parent()

enum LetterState {RISING, EARLY, PERFECT, LATE, OUT_OF_BOUNDS}

var state: LetterState = LetterState.RISING
var endPoint = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	endPoint = Vector2(self.position.x, self.position.y - 1000)

func _process(delta):
	position = position.move_toward(endPoint, delta*highway.get_speed())

func _input(event):
	if (event.is_action_pressed(highway.key_to_press)):
		match(state):
			LetterState.EARLY:
				print("EARLY")
			LetterState.PERFECT:
				print("PERFECT")
			LetterState.LATE:
				print("LATE")
			LetterState.OUT_OF_BOUNDS:
				print("OUT OF BOUNDS")
		queue_free()
			
func _on_perfect_key_press_area_body_entered(body: Letter):
	state = LetterState.PERFECT

func _on_out_key_press_area_body_entered(body: Letter):
	state = LetterState.OUT_OF_BOUNDS

func _on_late_key_press_area_body_entered(body: Letter):
	state = LetterState.LATE

func _on_early_key_press_area_body_entered(body: Letter):
	state = LetterState.EARLY

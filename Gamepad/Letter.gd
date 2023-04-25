extends CharacterBody2D
signal letterHighwayPressed

@onready var highway: Highway = get_parent()

enum LetterState {RISING, EARLY, PERFECT, LATE, OUT_OF_BOUNDS}

var state: LetterState = LetterState.RISING
var origin = Vector2(0, 0)
var endPoint = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("ready")
	origin = self.position
	endPoint = Vector2(self.position.x, self.position.y - 1000)

func _physics_process(delta):
	print("speed: ", highway.speed)
	position = position.move_toward(endPoint, delta*highway.speed)

func _input(event):
	if (event.is_action_pressed(highway.key_to_press)):
		var score = 0
		match(state):
			LetterState.EARLY:
				score = 5
				print("EARLY")
			LetterState.PERFECT:
				score = 10
				print("PERFECT")
			LetterState.LATE:
				score = 4
				print("LATE")
			LetterState.OUT_OF_BOUNDS:
				print("OUT OF BOUNDS")
			_:
				emit_signal("letterHighwayPressed", score)
				return
		emit_signal("letterHighwayPressed", score)
		queue_free()
			
func _on_perfect_key_press_area_body_entered(_body: Letter):
	state = LetterState.PERFECT

func _on_out_key_press_area_body_entered(_body: Letter):
	state = LetterState.OUT_OF_BOUNDS
	emit_signal("letterHighwayPressed", -10)

func _on_late_key_press_area_body_entered(_body: Letter):
	state = LetterState.LATE

func _on_early_key_press_area_body_entered(_body: Letter):
	state = LetterState.EARLY

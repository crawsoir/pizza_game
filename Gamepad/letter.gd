class_name Letter
extends CharacterBody2D
signal letterHighwayPressed

@onready var highway: Highway = get_parent()

enum LetterState {RISING, EARLY, PERFECT, LATE, OUT_OF_BOUNDS}

var state: LetterState = LetterState.RISING
var origin = Vector2(0, 0)
var endPoint = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	origin = self.position
	endPoint = Vector2(self.position.x, self.position.y - 1000)

func _physics_process(delta):
	position = position.move_toward(endPoint, delta*highway.speed)

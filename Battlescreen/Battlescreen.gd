extends Node2D
class_name BattleScreen

@onready var anim_controller = $AnimationController
@export var max_sus_score = 100

var current_sus_score = 50
var current_state = states.PREBATTLE

enum states { PREBATTLE, CAT_TURN, DOG_TURN, TRANSITION_DOG, TRANSITION_CAT }


func _ready():
	pass

func _process(delta):
	match(current_state):
		states.PREBATTLE:
			pass
		states.CAT_TURN:
			pass
		states.DOG_TURN:
			pass
		states.TRANSITION_CAT:
			pass
		states.TRANSITION_DOG:
			pass
		_:
			print("State not found: " + str(current_state))
			
func update_state(state):
	current_state = state
	anim_controller.update_state(state)
		

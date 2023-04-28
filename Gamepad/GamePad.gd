extends Node2D
class_name GamePad

var event_manager
var sus_score

func _ready():
	pass

func _process(delta):
	pass

# notes for bean -> 
# start_game() - disable and hide the gamepad before and after the games complete
# start_game() - the event manager holds its own state of which event its on, just call its get methods
# is_game_complete() - parent handles win condition, this is whether all letters are sent and done 
func start_game(parent_event_manager, initial_sus_score):
	# objects are pass by ref! (some types aren't)
	event_manager = parent_event_manager
	sus_score = initial_sus_score

func is_game_complete() -> bool:
	if sus_score < 0.1:
		return true
	return false
	
func get_sus_score() -> float:
	return sus_score - 0.01

extends Node2D
class_name BattleScreen

@onready var anim_manager = $AnimationManager
@onready var event_manager = $EventManager
@onready var game_pad = $GamePad

var sus_score = 0.5
var current_state = states.PREBATTLE

enum states { PREBATTLE, CAT_TURN, DOG_TURN, TRANSITION_DOG, TRANSITION_CAT, LOST, WON }


func _ready():
	pass

func _process(delta):
	match(current_state):
		states.PREBATTLE:
			await get_tree().create_timer(2).timeout
			process_event()
				
		states.DOG_TURN:
			# Update sus animations
			sus_score = game_pad.get_sus_score()
			if sus_score <= 0:
				update_state(states.LOST)
				anim_manager.update_dog_emotion_status("bad")
			elif sus_score <= 0.3:
				anim_manager.update_dog_emotion_status("bad")
			elif sus_score <= 0.7:
				anim_manager.update_dog_emotion_status("neutral")
			elif sus_score <= 1:
				anim_manager.update_dog_emotion_status("good")

			if game_pad.is_game_complete():
				event_manager.next_event()
				process_event()

		states.CAT_TURN:
			pass
			# call this when dialogue over
			#event_manager.next_event()
			#process_event()
		states.TRANSITION_DOG:
			pass
		states.TRANSITION_CAT:
			pass
		states.LOST:
			pass
		states.WON:
			pass
		_:
			print("Unknown state: " + str(current_state))

func process_event():
	if event_manager.battle_finished:
		update_state(states.WON)
	elif event_manager.event_is_battle():
		update_state(states.DOG_TURN)
		game_pad.start_game(event_manager, sus_score)
	elif event_manager.event_is_dialogue():
		update_state(states.CAT_TURN)

func update_state(state):
	current_state = state
	anim_manager.update_state(state)

func update_sus_score(score):
	sus_score = score

extends Control
class_name BattleScreen

@onready var bg_colour = $BgColour
@onready var anim_manager = $AnimationManager
@onready var event_manager = $EventManager
@onready var game_pad = $GamePad
@onready var prebattle_timer = $PrebattleTimer

#would be nice to refactor this into a class object, so we dont have to manually reset it
@onready var interactive_dialogue = $InteractiveDialogueBox

var sus_score = 50
var current_state = states.PREBATTLE

enum states { PREBATTLE, CAT_TURN, DOG_TURN, TRANSITION_DOG, TRANSITION_CAT, LOST, WON }


func _ready():
	bg_colour.move_in()
	interactive_dialogue.visible = false

func _process(delta):
	match(current_state):
		states.PREBATTLE:
			if prebattle_timer.is_stopped():
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
			if interactive_dialogue.dialogue_finished:
				interactive_dialogue.clear()
				interactive_dialogue.visible = false
				event_manager.next_event()
				process_event()
				
		states.TRANSITION_DOG:
			bg_colour.move_in()
		states.TRANSITION_CAT:
			bg_colour.move_out()
		states.LOST:
			pass
		states.WON:
			pass
			
		_:
			print("Unknown state: " + str(current_state))
	
func process_event():
	if event_manager.battle_finished:
		interactive_dialogue.visible = true
		interactive_dialogue.set_dialogue(event_manager.get_win_dialogue())
		update_state(states.WON)
	elif event_manager.event_is_battle():
		update_state(states.DOG_TURN)
		game_pad.start_game(event_manager, sus_score)
	elif event_manager.event_is_dialogue():
		update_state(states.CAT_TURN)
		interactive_dialogue.visible = true
		interactive_dialogue.set_dialogue(event_manager.get_dialogue())

func update_state(state):
	current_state = state
	anim_manager.update_state(state)

func update_sus_score(score):
	sus_score = score
	
func move_dog_mouth():
	anim_manager.activate_dog_talk()

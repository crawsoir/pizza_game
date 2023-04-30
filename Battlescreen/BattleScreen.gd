extends Control
class_name BattleScreen

@onready var bg_colour = $BgColour
@onready var anim_manager = $AnimationManager
@onready var event_manager = $EventManager
@onready var game_pad = $GamePad
@onready var prebattle_timer = $PrebattleTimer
@onready var round_timer = $RoundTimer

#would be nice to refactor this into a class object, so we dont have to manually reset it
@onready var interactive_dialogue = $InteractiveDialogueBox

var sus_score = 50
var current_state = states.PREBATTLE

enum states { PREBATTLE, CAT_TURN, DOG_TURN, TRANSITION_DOG, TRANSITION_CAT, LOST, WON }


func _ready():
	bg_colour.move_in()
	interactive_dialogue.visible = false
	GlobalAudioStream.set_music_db(-8)

func _process(delta):
	match(current_state):
		states.PREBATTLE:
			if prebattle_timer.is_stopped():
				process_event()
				
		states.DOG_TURN:
			# Update sus animations
			sus_score = game_pad.get_sus_score()
			if sus_score <= 0:
				anim_manager.update_dog_emotion_status("bad")
			elif sus_score <= 30:
				anim_manager.update_dog_emotion_status("bad")
			elif sus_score <= 65:
				anim_manager.update_dog_emotion_status("neutral")
			elif sus_score <= 100:
				anim_manager.update_dog_emotion_status("good")

			if game_pad.is_game_complete():
				if game_pad.get_result_is_real_word():
					event_manager.next_event()
				process_event()
				
		states.CAT_TURN:
			if interactive_dialogue.dialogue_finished:
				interactive_dialogue.clear()
				interactive_dialogue.visible = false
				if not event_manager.event_is_battle(): 
					event_manager.next_event()
				process_event()
					
		states.TRANSITION_DOG:
			bg_colour.move_in()
		states.TRANSITION_CAT:
			bg_colour.move_out()
		states.LOST:
			if interactive_dialogue.dialogue_finished:
				interactive_dialogue.clear()
				interactive_dialogue.visible = false
				Global.goto_scene(Global.GAME_OVER_SCREEN)
		states.WON:
			if interactive_dialogue.dialogue_finished:
				interactive_dialogue.clear()
				interactive_dialogue.visible = false
				Global.goto_scene(Global.VICTORY_SCREEN)
			
		_:
			print("Unknown state: " + str(current_state))
	
func process_event():	
	if event_manager.battle_finished:
		update_state(states.WON)
		interactive_dialogue.visible = true
		interactive_dialogue.set_dialogue(event_manager.get_win_dialogue())
	elif event_manager.event_is_battle():
		if sus_score <= 0:
			update_state(states.LOST)
			interactive_dialogue.visible = true
			interactive_dialogue.set_dialogue(event_manager.get_lose_dialogue())
		elif !game_pad.game_played or current_state == states.CAT_TURN:
			update_state(states.DOG_TURN)
			game_pad.start_game(event_manager, sus_score)
			round_timer.start()
			round_timer.visible = true
			interactive_dialogue.clear()
			interactive_dialogue.visible = false
		elif !game_pad.get_result_is_real_word():
			update_state(states.CAT_TURN)
			round_timer.stop()
			interactive_dialogue.visible = true
			interactive_dialogue.set_dialogue(event_manager.get_hint_dialogue())
	elif event_manager.event_is_dialogue():
		update_state(states.CAT_TURN)
		round_timer.stop()
		interactive_dialogue.visible = true
		interactive_dialogue.set_dialogue(event_manager.get_dialogue())

func round_timer_over():
	game_pad.stop_game()
	round_timer.visible = false
	
func update_state(state):
	current_state = state
	anim_manager.update_state(state)

func update_sus_score(score):
	sus_score = score
	
func move_dog_mouth():
	if current_state == states.DOG_TURN:
		anim_manager.activate_dog_talk()

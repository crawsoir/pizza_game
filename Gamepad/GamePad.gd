class_name GamePad
extends Node2D

@onready var game_play_manager: GamePlayManager = $GamePlayManager
@onready var highways = [$LetterHighway, $LetterHighway2, $LetterHighway3, $LetterHighway4]
@onready var sus_meter = $SusMeter

@export var speed = 100
@export var min_time = 0.5
@export var max_time = 1

var event_manager: EventManager
var letters = []

var timer = 0
var game_ongoing = true

func _ready():
	pass

func _process(delta):
	if (!game_ongoing):
		return
	timer -= delta
	if timer < 0:
		highways[randi() % highways.size()].send_letter(game_play_manager.generate_new_letter())
		timer = randf_range(min_time, max_time)

# notes for bean -> 
# start_game() - disable and hide the gamepad before and after the games complete
# start_game() - the event manager holds its own state of which event its on, just call its get methods
# is_game_complete() - parent handles win condition, this is whether all letters are sent and done 
func start_game(parent_event_manager, initial_sus_score):
	# objects are pass by ref! (some types aren't)
	event_manager = parent_event_manager
	game_ongoing = false
	game_play_manager.start_new_round(event_manager.get_battle_word_list())
	sus_meter.value = initial_sus_score

func is_game_complete() -> bool:
	return game_ongoing
	
func get_sus_score() -> float:
	return sus_meter.value

func _on_game_play_manager_word_completed(_word: String, _score: int):
	game_ongoing = true

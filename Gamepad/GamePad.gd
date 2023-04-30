class_name GamePad
extends Node2D
signal inputFromGamepad

@onready var game_play_manager: GamePlayManager = $GamePlayManager
@onready var highways = [$LetterHighway, $LetterHighway2, $LetterHighway3, $LetterHighway4]
@onready var dialog_box: LiveDialogBox = $LiveDialogueBox

@export var speed = 100
@export var min_time: float = 0.5
@export var max_time: float = 1

var event_manager: EventManager
var letters = []

var timer = 0
var game_played = false
var game_ongoing = false
var game_result = false
	
func _ready():
	dialog_box.clear()

func _process(delta):
	if (game_ongoing):
		timer -= delta
		if timer < 0:
			highways[randi() % highways.size()].send_letter(game_play_manager.generate_new_letter())
			timer = randf_range(min_time, max_time)


func start_game(parent_event_manager, initial_sus_score):
	# objects are pass by ref! (some types aren't)
	event_manager = parent_event_manager
	game_ongoing = true
	game_played = true
	game_play_manager.start_new_round(event_manager.get_battle_word_list())
	game_play_manager.score = initial_sus_score
	dialog_box.clear()
	dialog_box.show()
	for highway in highways:
		highway.visible = true

func is_game_complete() -> bool:
	return !game_ongoing and game_played
	
func get_sus_score() -> float:
	return game_play_manager.score

func click() :
	if game_ongoing:
		emit_signal("inputFromGamepad")
	
func stop_game():
	dialog_box.clear()
	dialog_box.hide()
	for highway in highways:
		highway.visible = false
		highway.free_letters()
	game_ongoing = false
	
func get_result_is_real_word():
	return game_play_manager.result
	
func time_stop_game():
	game_play_manager.update_score(-10)
	stop_game()
	
func _on_game_play_manager_word_completed(_word: String):
	stop_game()


func on_letter_highway_add_letter(dist, letter):
	dialog_box.add_text(letter)

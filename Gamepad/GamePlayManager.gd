class_name GamePlayManager
extends Node
signal wordCompleted
signal updateScore
signal wordAssessment

@export var perfect_range = 5
@export var late_range = 30

@export var perfect_score = 0
@export var late_score = -1
@export var very_late_score = -5

var score = 50
var score_change = 0
var word_bank = {}
var letters = []
var created_word = ""
var result = false

func start_new_round(word_list):
	word_bank = {}
	letters = []
	created_word = ""
	for word in word_list:
		word_bank[word["word"]] = word["score"]
		letters = letters + Array(word["word"].split())
	
func generate_new_letter():
	if (letters.size() == 0):
		return "w"
	return letters[randi() % letters.size()]

func update_score(val):
	score += val
	print(score)
	
func _on_letter_highway_add_letter(dist: int, letter: String):
	if (abs(dist) <= perfect_range):
		score_change += perfect_score
	elif (abs(dist) <= late_range):
		score_change += late_score
	else:
		score_change += very_late_score
		
	created_word += letter
	if (len(created_word) < 4):
		return
		
	result = created_word in word_bank
	if (result):
		emit_signal("wordCompleted", created_word)
		update_score(word_bank[created_word])
	else:
		emit_signal("wordCompleted", created_word)
		update_score(-5)
	created_word = ""
	score_change = 0

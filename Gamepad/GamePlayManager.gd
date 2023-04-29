class_name GamePlayManager
extends Node
signal wordCompleted(String, int)

@export var perfect_range = 5
@export var late_range = 30

@export var perfect_score = 0
@export var late_score = -1
@export var very_late_score = -5

var score_change = 0
var word_bank = {}
var letters = []
var createdWord = ""

func start_new_round(word_list):
	word_bank = {}
	letters = []
	createdWord = ""
	for word in word_list:
		word_bank[word["word"]] = word["score"]
		letters = letters + Array(word["word"].split())
	
func generate_new_letter():
	if (letters.size() == 0):
		return "w"
	return letters[randi() % letters.size()]

func _on_letter_highway_add_letter(dist: int, letter: String):
	if (abs(dist) <= perfect_range):
		score_change += perfect_score
	elif (abs(dist) <= late_range):
		score_change += late_score
	else:
		score_change += very_late_score
		
	createdWord += letter
	if (len(createdWord) == 4):
		if (createdWord in word_bank):
			emit_signal("wordCompleted", createdWord, word_bank[createdWord] - score_change)
		else:
			emit_signal("wordCompleted", createdWord, score_change - 1)
		createdWord = ""
		score_change = 0

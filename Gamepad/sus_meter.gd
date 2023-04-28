class_name SusMeter
extends ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

	
func changeSusLevel(amount):
	print(amount)


func _on_letter_highway_change_sus_amount(amount):
	print(amount)
	self.value += amount


func _on_game_play_manager_word_completed(word: String, score: int):
	print(word, score)
	self.value += score

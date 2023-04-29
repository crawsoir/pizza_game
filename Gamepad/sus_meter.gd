class_name SusMeter
extends ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_game_play_manager_word_completed(score: int):
	self.value += score

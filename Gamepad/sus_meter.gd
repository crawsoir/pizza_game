class_name SusMeter
extends ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func changeSusLevel(amount):
	print(amount)


func _on_letter_highway_change_sus_amount(amount):
	print(amount)
	self.value += amount

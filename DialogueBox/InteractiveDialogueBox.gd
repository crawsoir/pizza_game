extends Panel

@onready var timer = $Timer

var text_speed = 0.05
var dialogue
var phrase_num = 0
var phrase_finished = false
var dialogue_finished = false

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = text_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if phrase_finished:
			_next_phrase()
		else:    
			$Text.visible_characters = len($Text.text)

func set_dialogue(dialogue_param):
	dialogue = dialogue_param
	_next_phrase()
	
func _next_phrase():
	if dialogue == null:
		print("No dialogue set")
		return

	if phrase_num >= len(dialogue):
		dialogue_finished = true
		return
	
	phrase_finished = false
	var phrase = dialogue[phrase_num]
	$Text.visible_characters = 0
	$Text.bbcode_text = dialogue[phrase_num]["text"]
	
	
	if phrase.has("name"):
		$Name.bbcode_text = phrase["name"]
	else:
		$Name.bbcode_text = "Cat"
		
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		
	phrase_finished = true
	phrase_num += 1
	return
	

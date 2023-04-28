extends Panel

@onready var text = $RichTextLabel
var bad_word = ""
var good_word = ""

func _ready():
	pass
	
func _process(delta):
	pass

func add_text(text):
	$text.append_text(text)

func clear():
	$text.clear()

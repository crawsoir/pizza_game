extends Panel

@onready var text = $RichTextLabel
var bad_word = ""
var good_word = ""
	
func add_text(txt):
	text.append_text(txt)

func clear():
	text.clear()

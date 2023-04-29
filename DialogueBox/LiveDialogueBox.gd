class_name LiveDialogBox
extends Panel

@onready var text = $RichTextLabel
var bad_word = ""
var good_word = ""
	
func add_text(txt):
	if not $AudioStreamPlayer.stream == null:
		$AudioStreamPlayer.playing = true
		$AudioStreamPlayer.volume_db = randf_range(-20,-15)
	text.append_text(txt)

func clear():
	text.clear()

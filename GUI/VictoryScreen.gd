extends Control


func _ready():
	$AnimationPlayer.play("default")
	GlobalAudioStream.set_music_db(-17)

func _on_menu_pressed():
	Global.goto_scene(Global.START_SCREEN)

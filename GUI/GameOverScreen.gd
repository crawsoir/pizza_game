extends Control

func _ready():
	GlobalAudioStream.set_music_db(-17)

func _on_main_menu_pressed():
	Global.goto_scene(Global.START_SCREEN)

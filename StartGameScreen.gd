extends Control

func _ready():
	$AnimationPlayer.play("default")

func _on_quit_pressed():
	get_tree().quit()

func _on_start_pressed():
	Global.goto_scene(Global.BATTLE_SCREEN)

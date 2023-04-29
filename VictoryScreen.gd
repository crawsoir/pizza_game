extends Control


func _ready():
	$AnimationPlayer.play("default")

func _on_menu_pressed():
	Global.goto_scene(Global.START_SCREEN)

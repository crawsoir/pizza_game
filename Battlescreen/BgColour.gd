extends Control

@onready var animation_player = $AnimationPlayer
@onready var battle_screen = get_parent()


# general animations
enum {
	MOVE_IN, MOVE_OUT
}

var anim_map = {
	MOVE_IN: "move_in", 
	MOVE_OUT: "move_out"
}

func move_in():
	animation_player.play(anim_map[MOVE_IN])
	
func move_out():
	animation_player.play(anim_map[MOVE_OUT])
	

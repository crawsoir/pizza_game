extends Node2D

enum states { PREBATTLE, CAT_TURN, DOG_TURN, TRANSITION_DOG, TRANSITION_CAT }
var current_state = states.DOG_TURN

@onready var dog = $Dog
@onready var cat = $Cat
@onready var animation_player = $AnimationPlayer

@export var cat_name = "cat1"
@export var dog_name = "dog"

# general animations
enum {
	CAT_BEHIND, CAT_FRONT, CAT_SUS, DOG_PREGAME, DOG_NEUTRAL_CLOSED, DOG_NEUTRAL_OPEN, 
	DOG_GOOD_CLOSED, DOG_GOOD_OPEN, DOG_BAD_CLOSED, DOG_BAD_OPEN, DOG_BEHIND
}

var anim_map = {
	CAT_BEHIND: cat_name + "_behind",
	CAT_FRONT: cat_name + "_front",
	CAT_SUS: cat_name + "_sus",
	DOG_PREGAME: dog_name + "_pregame",
	DOG_NEUTRAL_CLOSED: dog_name + "_neutral_closed",
	DOG_NEUTRAL_OPEN: dog_name + "_neutral_open",
	DOG_GOOD_CLOSED: dog_name + "_good_closed",
	DOG_GOOD_OPEN: dog_name + "_good_open",
	DOG_BAD_CLOSED: dog_name + "bad_closed",
	DOG_BAD_OPEN: dog_name + "_bad_open",
	DOG_BEHIND: dog_name + "_behind",
}

func _ready():
	cat.animation = anim_map[CAT_BEHIND]
	dog.animation = anim_map[DOG_PREGAME]
	animation_player.play("dog_turn")

func _process(delta):
	if Input.is_action_pressed("a_key"):
		print(current_state)
		if current_state == states.DOG_TURN:
			switch_to_cat()
		else:
			switch_to_dog()
			

func start_battle():
	pass

func switch_to_cat():
	animation_player.play("transition_to_cat")
	
func switch_to_dog():
	animation_player.play("transition_to_dog")
	
	
# functions called by the animation player	
func switch_to_cat_animation_trigger():
	cat.animation = anim_map[CAT_FRONT]
	dog.animation = anim_map[DOG_BEHIND]
	
func switch_to_dog_animation_trigger():
	cat.animation = anim_map[CAT_BEHIND]
	dog.animation = anim_map[DOG_PREGAME]


func _on_animation_player_animation_finished(anim_name):
	match(anim_name):
		"transition_to_cat":
			animation_player.play("cat_turn")
			current_state = states.CAT_TURN
		"transition_to_dog":
			animation_player.play("dog_turn")
			current_state = states.DOG_TURN

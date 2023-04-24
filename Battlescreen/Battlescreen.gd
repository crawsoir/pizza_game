extends Node2D

enum states { PREBATTLE, CAT_TURN, DOG_TURN, TRANSITION_DOG, TRANSITION_CAT }
var current_state = states.DOG_TURN

@onready var dog = $Dog
@onready var cat = $Cat
@onready var animation_player = $AnimationPlayer
@onready var dog_talk_timer = $DogTalkTimer

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
	dog.animation = anim_map[DOG_NEUTRAL_CLOSED]
	animation_player.play("dog_turn")

func _process(delta):
	# temp code
	if Input.is_action_pressed("a_key"):
		if current_state == states.DOG_TURN:
			switch_to_cat()
		elif current_state == states.CAT_TURN:
			switch_to_dog()
			
	if Input.is_action_just_pressed("d_key"):
		if current_state == states.DOG_TURN:
			activate_dog_talk()
		
			
func activate_dog_talk():
	var previous_anim = dog.animation
	dog.animation = anim_map[DOG_NEUTRAL_OPEN]
	if dog_talk_timer.is_stopped():
		dog_talk_timer.start()
		await dog_talk_timer.timeout
	dog.animation = previous_anim

func switch_to_cat():
	current_state = states.TRANSITION_CAT
	dog.animation = anim_map[DOG_PREGAME]
	animation_player.play("transition_to_cat")
	
func switch_to_dog():
	current_state = states.TRANSITION_DOG
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
			dog.animation = anim_map[DOG_NEUTRAL_CLOSED]
			current_state = states.DOG_TURN

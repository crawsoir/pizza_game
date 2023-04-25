extends Node2D
class_name AnimationManager

@onready var battle_screen: BattleScreen = get_parent()

@onready var dog = $Dog
@onready var cat = $Cat
@onready var animation_player = $AnimationPlayer
@onready var dog_talk_timer = $DogTalkTimer

@export var cat_name = "cat1"
@export var dog_name = "dog"

var dog_emotion_status = "neutral" # bad, neutral, good
var current_state

# general animations
enum {
	CAT_BEHIND, CAT_FRONT, CAT_SUS, DOG_PREGAME, DOG_CLOSED, DOG_OPEN, DOG_BEHIND
}

var anim_map = {
	CAT_BEHIND: cat_name + "_behind",
	CAT_FRONT: cat_name + "_front",
	CAT_SUS: cat_name + "_sus",
	DOG_PREGAME: dog_name + "_pregame",
	DOG_CLOSED: dog_name + "_" + dog_emotion_status + "_closed",
	DOG_OPEN: dog_name + "_" + dog_emotion_status + "_open",
	DOG_BEHIND: dog_name + "_behind",
}

func _ready():
	current_state = battle_screen.current_state
	cat.animation = anim_map[CAT_BEHIND]
	dog.animation = anim_map[DOG_PREGAME]
	animation_player.play("dog_turn")

func _process(delta):
	# ALL TEMP CODE TO SHOW OFF ANIMATIONS
	if current_state == battle_screen.states.DOG_TURN:
		if Input.is_action_just_pressed("a_key"):
			switch_to_cat()
				
		if Input.is_action_just_pressed("d_key"):
			activate_dog_talk()
		
		if Input.is_action_just_pressed("z_key"):
			update_dog_emotion_status("bad")
				
		if Input.is_action_just_pressed("x_key"):
			update_dog_emotion_status("neutral")
				
		if Input.is_action_just_pressed("c_key"):
			update_dog_emotion_status("good")
			
	elif current_state == battle_screen.states.CAT_TURN:
		if Input.is_action_just_pressed("a_key"):
			switch_to_dog()
			
	elif current_state == battle_screen.states.PREBATTLE:
		if Input.is_action_just_pressed("d_key"):
			dog.animation = anim_map[DOG_CLOSED]
			battle_screen.update_state(battle_screen.states.DOG_TURN)

# called by parent. dont call directly in this class
# update state by calling the parent method
func update_state(state):
	if current_state == battle_screen.states.PREBATTLE:
		dog.animation = anim_map[DOG_CLOSED]
	
	current_state = state
	
func update_dog_emotion_status(status):
	dog_emotion_status = status
	rebuild_anim_dict()

# mainly used after updating dog status
func rebuild_anim_dict():
	anim_map = {
		CAT_BEHIND: cat_name + "_behind",
		CAT_FRONT: cat_name + "_front",
		CAT_SUS: cat_name + "_sus",
		DOG_PREGAME: dog_name + "_pregame",
		DOG_CLOSED: dog_name + "_" + dog_emotion_status + "_closed",
		DOG_OPEN: dog_name + "_" + dog_emotion_status + "_open",
		DOG_BEHIND: dog_name + "_behind",
	}
	dog.animation = anim_map[DOG_CLOSED]

func activate_dog_talk():
	var previous_anim = dog.animation
	dog.animation = anim_map[DOG_OPEN]
	if dog_talk_timer.is_stopped():
		dog_talk_timer.start()
		await dog_talk_timer.timeout
	dog.animation = previous_anim

func switch_to_cat():
	current_state = battle_screen.states.TRANSITION_CAT
	dog.animation = anim_map[DOG_PREGAME]
	animation_player.play("transition_to_cat")
	
func switch_to_dog():
	current_state = battle_screen.states.TRANSITION_DOG
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
			battle_screen.update_state(battle_screen.states.CAT_TURN)
		"transition_to_dog":
			animation_player.play("dog_turn")
			dog.animation = anim_map[DOG_CLOSED]
			battle_screen.update_state(battle_screen.states.DOG_TURN)

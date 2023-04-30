class_name EventManager
extends Node

@export_file var json_path

var battle
var event
var event_type
var event_num = 0
var battle_finished = false

func _ready():
	battle = _get_json_file_data()
	next_event()	
	
func _get_json_file_data():
	var file = FileAccess.open(json_path, FileAccess.READ)
	var json = JSON.new()
	var parse_err = json.parse(file.get_as_text())
	return json.get_data()
	
func next_event():
	if event_num >= len(battle["events"]):
		battle_finished = true
		return
		
	battle_finished = false
	event = battle["events"][event_num]
	event_type = get_event_type()
	event_num += 1
	
func event_is_battle():
	return get_event_type() == "battle"
	
func event_is_dialogue():
	return get_event_type() == "dialogue"
	
func get_battle_word_list():
	assert(event_is_battle(), "Cannot fetch word list, Event is not type \"battle\"")
	return event["word_list"]
	
func get_dialogue():
	assert(event_is_dialogue(), "Cannot fetch dialogue, Event is not type \"dialogue\"")
	return event["dialogue"]

func get_hint_dialogue():
	assert(event_is_battle(), "Cannot fetch word list, Event is not type \"battle\"")
	return event["hint"]
	
func get_win_dialogue():
	return battle["win_dialogue"]
	
func get_lose_dialogue():
	return battle["lose_dialogue"]
	
func get_cat_number():
	return battle["metadata"]["cat_number"]
	
func get_cat_name():
	return battle["metadata"]["cat_number"]
	
func get_track_speed():
	return battle["metadata"]["track_speed"]
	
func get_event_type():
	return event["type"]

extends Node

@onready var audio_player = $AudioStreamPlayer

func set_music_db(db):
	audio_player.volume_db = db
	
func pause():
	audio_player.stream_paused = true
	
func play():
	audio_player.stream_paused = false

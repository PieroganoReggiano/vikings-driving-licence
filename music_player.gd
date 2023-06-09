extends AudioStreamPlayer

@export var menu_track : AudioStream
@export var pause_menu_track : AudioStream
@export var level1_track : AudioStream

func play_menu():
	if not playing or stream != menu_track:
		stream = menu_track
		play()

func play_pause_menu():
	if not playing or stream != menu_track:
		stream = pause_menu_track
		play()
		
func play_level():
	if not playing or stream != level1_track:
		stream = level1_track
		play()


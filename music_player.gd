extends AudioStreamPlayer

@export var menu_track : AudioStream
@export var pause_menu_track : AudioStream
@export var level1_track : AudioStream
@export var win_track : AudioStream
@export var lose_track : AudioStream
@export var final_track : AudioStream

var is_playing_level = false
var level_music_time

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

func play_win():
	if not playing or stream != win_track:
		stream = win_track
		play()

func play_lose():
	if not playing or stream != lose_track:
		stream = lose_track
		play()

func play_final():
	if not playing or stream != final_track:
		stream = final_track
		play()

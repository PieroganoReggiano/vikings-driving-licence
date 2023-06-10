extends AudioStreamPlayer

@export var menu_track : AudioStream
@export var pause_menu_track : AudioStream
@export var default_level_track : AudioStream
@export var win_track : AudioStream
@export var lose_track : AudioStream
@export var final_track : AudioStream

var is_playing_level_music : bool = false
var prepared_level_music : AudioStream = null
var prepared_level_music_time : float = 0.0

func play_menu():
	if not playing or stream != menu_track:
		store_level_music()
		stream = menu_track
		play()

func play_pause_menu():
	if not playing or stream != menu_track:
		store_level_music()
		stream = pause_menu_track
		play()
		
func prepare_level(stream : AudioStream):
	prepared_level_music = stream
	prepared_level_music_time = 0.0
	
func prepare_default_level():
	prepare_level(default_level_track)

func play_win():
	if not playing or stream != win_track:
		store_level_music()
		stream = win_track
		play()

func play_lose():
	if not playing or stream != lose_track:
		store_level_music()
		stream = lose_track
		play()

func play_final():
	if not playing or stream != final_track:
		store_level_music()
		stream = final_track
		play()
		
func store_level_music():
	if is_playing_level_music:
		prepared_level_music = stream
		prepared_level_music_time = get_playback_position()
		is_playing_level_music = false

func return_to_level():
	restore_level_music()

func restore_level_music():
	if prepared_level_music != null:
		stream = prepared_level_music
		play()
		seek(prepared_level_music_time)
		prepared_level_music = null
		prepared_level_music_time = 0.0
		is_playing_level_music = true
	

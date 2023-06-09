extends Node

const default_level = preload("res://default_level.tscn")

const menu_scene = preload("res://menu.tscn")
const pause_menu_scene = preload("res://pause_menu.tscn")

func restart():
	load_level(default_level)
	drop_menu()

func play():
	if $"Level" == null:
		load_level(default_level)
	drop_menu()
		
func quit():
	get_tree().quit()
	
func show_menu():
	drop_menu()
	var is_this_pause_menu = is_any_game()
	var menu_to_create = (pause_menu_scene if is_this_pause_menu else menu_scene)
	var menu_created = menu_to_create.instantiate()
	add_child(menu_created)
	menu_created.name = "Menu"
	get_tree().paused = true
	if music():
		if is_this_pause_menu:
			music().play_pause_menu()
		else:
			music().play_menu()



func drop_menu():
	if $"Menu" != null:
		var menu = $"Menu"
		remove_child(menu)
		menu.queue_free()
	get_tree().paused = false
	if music():
		if is_any_game():
			music().play_level()
		
func is_any_game():
	return $"Level" != null
	
func drop_level():
	if is_any_game():
		var level = $"Level"
		remove_child(level)
		level.queue_free()

func load_level(level):
	drop_level()
	var level_created = default_level.instantiate()
	add_child(level_created)
	level_created.name = "Level"
	get_tree().paused = false


func _ready():
	show_menu()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if $"Menu" == null:
			show_menu()

func music():
	return $"MusicPlayer"


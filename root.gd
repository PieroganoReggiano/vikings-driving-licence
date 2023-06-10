extends Node

const level01 = preload("res://levels/level01.tscn")

const menu_scene = preload("res://menu.tscn")
const pause_menu_scene = preload("res://pause_menu.tscn")
const menu_win_scene = preload("res://menu_win.tscn")
const menu_lose_scene = preload("res://menu_lose.tscn")

var dragon = null

var current_level_resource : Resource

func restart():
	load_level(level01)
	drop_menu()
	
func restart_level():
	load_level(current_level_resource)
	drop_menu()

func play():
	if $"Level" == null:
		load_level(level01)
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

func show_win():
	if not is_any_game():
		return
	drop_menu()
	var menu_created = menu_win_scene.instantiate()
	add_child(menu_created)
	menu_created.name = "Menu"
#	get_tree().paused = true
	if music():
		music().play_win()

func show_lose():
	if not is_any_game():
		return
	drop_menu()
	var menu_created = menu_lose_scene.instantiate()
	add_child(menu_created)
	menu_created.name = "Menu"
#	get_tree().paused = true
	if music():
		music().play_lose()

func drop_menu():
	if get_node_or_null("Menu") != null:
		var menu = $"Menu"
		remove_child(menu)
		menu.queue_free()
	get_tree().paused = false
	if music():
		if is_any_game():
			music().return_to_level()

func is_any_game():
	return get_node_or_null("Level") != null

func drop_level():
	if is_any_game():
		var level = $"Level"
		remove_child(level)
		level.queue_free()

func load_level(level):
	drop_level()
	var level_created = level.instantiate()
	add_child(level_created)
	level_created.name = "Level"
	current_level_resource = level
	get_tree().paused = false
	if music():
		if level_created.level_music != null:
			music().prepare_level(level_created.level_music)
		else:
			music().prepare_default_level()

func next_level():
	if not is_any_game():
		return
	var next_level = $"Level".next_level
	if next_level == null:
		drop_level()
		show_menu()
	else:
		load_level(next_level)
		drop_menu()

func _ready():
	show_menu()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if get_node_or_null("Menu") == null:
			show_menu()
	if Input.is_action_just_pressed("hack_next_level"):
		next_level()

func _physics_process(delta):
	process_game_status()

func process_game_status():
	if not is_any_game() or get_node_or_null("/root/Root/Menu"):
		return
#	if $"Controller".control == null:
#		return
#	var dragon = $"Controller".control.get_node("..")
	if dragon == null:
		return
	if dragon.shall_lose:
#		get_tree().paused = true
		show_lose()
	elif dragon.shall_win:
#		get_tree().paused = true
		show_win()

func music():
	return get_node_or_null("MusicPlayer")


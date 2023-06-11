extends Node

@onready var root = $".."

func _on_play_sound():
	root.play_gui_sound()

func _on_button_menu_pressed():
	root.show_menu()
	

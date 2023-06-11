extends CanvasLayer

@onready var root = $".."


func _on_play_sound():
	root.play_gui_sound()

func _on_button_restart_pressed():
	root.restart_level()


func _on_button_menu_pressed():
	root.drop_level()
	root.show_menu()

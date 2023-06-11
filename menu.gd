extends Node

@onready var root = $".."

func _on_play_sound():
	root.play_gui_sound()

func _on_button_play_pressed():
	root.play()
	

func _on_button_quit_pressed():
	root.quit()


func _on_button_credits_pressed():
	root.show_credits()

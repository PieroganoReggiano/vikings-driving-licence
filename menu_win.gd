extends CanvasLayer

@onready var root = $".."


func _on_play_sound():
	root.play_gui_sound()

func _on_button_next_pressed():
	root.next_level()

extends Node

@onready var root = $".."


func _on_play_sound():
	root.play_gui_sound()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		root.play()


func _on_button_resume_pressed():
	root.play()
	
func _on_button_restart_pressed():
	root.restart_level()
	

func _on_button_quit_pressed():
	root.drop_level()
	root.show_menu()

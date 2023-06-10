extends Node



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		$"..".play()


func _on_button_resume_pressed():
	$"..".play()
	
func _on_button_restart_pressed():
	$"..".restart_level()
	

func _on_button_quit_pressed():
	$"..".quit()

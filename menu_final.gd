extends CanvasLayer

@export var skip_shortcut : Shortcut

var time : float = 0.0

func _on_button_menu_pressed():
	$"..".drop_level()
	$"..".show_menu()


func _process(delta):
	time += delta
	#if time > 5.0:
	#	$TextureRect/ButtonMenu.shortcut = skip_shortcut

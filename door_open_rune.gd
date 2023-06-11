extends "res://rune_trigger.gd"

@export var door : Node = null

func trigger(_dragon):
	if door != null:
		door.start_open()

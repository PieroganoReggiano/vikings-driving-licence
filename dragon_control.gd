extends Node

var move_vector = Vector2.ZERO

func get_dragon():
	return $".."

func set_vector(vec:Vector2):
	move_vector = vec

func _process(delta):
	if (get_dragon() == null):
		print_debug("error: dragon controller does not have dragon")
	get_dragon().set_vector(move_vector)

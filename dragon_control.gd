extends Node

var move_vector = Vector2.ZERO
var do_fire = false

func get_dragon():
	return $".."

func set_vector(vec:Vector2):
	move_vector = vec
	
func fire_fireball():
	do_fire = true

func _process(delta):
	if (get_dragon() == null):
		print_debug("error: dragon controller does not have dragon")
		
	get_dragon().set_vector(move_vector)
	if do_fire:
		get_dragon().do_fire = true
		do_fire = false

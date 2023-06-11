extends Area2D

const DragonClass = preload("res://dragon.gd")

var dragons = []

func trigger(dragon):
	pass

func _on_body_entered(body):
	if body is DragonClass:
		dragons.append(body)


func _on_body_exited(body):
	dragons.erase(body)

func _physics_process(delta):
	for dragon in dragons:
		var velocity = dragon.linear_velocity.length()
		var distance_square = position.distance_squared_to(dragon.position)
		if velocity < 0.01 and distance_square < 500:
			trigger(dragon)

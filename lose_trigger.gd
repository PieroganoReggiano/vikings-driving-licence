extends Area2D

const DragonClass = preload("res://dragon.gd")

@export var grounds : bool = false

func trigger(dragon):
	dragon.shall_lose = true
	dragon.grounded = grounds or dragon.grounded

func _on_body_entered(body):
	if body is DragonClass:
		trigger(body)

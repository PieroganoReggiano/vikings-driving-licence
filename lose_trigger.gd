extends Area2D

const DragonClass = preload("res://dragon.gd")

enum TYPE { none, ground, water }

@export var type : TYPE = TYPE.none

func trigger(dragon):
	dragon.shall_lose = true
	if type == TYPE.ground:
		dragon.grounded = true
	elif type == TYPE.water:
		dragon.drown()

func _on_body_entered(body):
	if body is DragonClass:
		trigger(body)

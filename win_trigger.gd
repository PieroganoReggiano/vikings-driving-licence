extends Area2D

const DragonClass = preload("res://dragon.gd")

func _on_body_entered(body):
	if body is DragonClass:
		body.shall_win = true

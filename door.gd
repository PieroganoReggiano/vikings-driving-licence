extends Node2D

const DragonClass = preload("res://dragon.gd")

func _ready():
	$"StaticBody2D".add_child($"CollisionShape2D".duplicate())

func open():
	$"Icon".modulate = Color(0.5, 0.5, 0.5, 1.0)
	$"CollisionShape2D".shape = null
	$"StaticBody2D/CollisionShape2D".shape = null


func _on_body_entered(body):
	if body is DragonClass:
		body.shall_lose = true

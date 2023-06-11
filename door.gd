extends Node2D

const DragonClass = preload("res://dragon.gd")

func _ready():
	$"StaticBody2D".add_child($"CollisionShape2D".duplicate())

func start_open():
	$AnimatedSprite2D.play("hide")
	#$"Icon".modulate = Color(0.5, 0.5, 0.5, 1.0)
	
func finish_open():
	$"CollisionShape2D".shape = null
	$"StaticBody2D/CollisionShape2D".shape = null
	$AnimatedSprite2D.play("idle")
	$AnimatedSprite2D.visible = false


func _on_body_entered(body):
	if body is DragonClass:
		body.shall_lose = true



func _on_animated_sprite_2d_animation_looped():
	finish_open()

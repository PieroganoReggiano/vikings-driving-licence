extends Node2D

const DragonClass = preload("res://dragon.gd")

var was_ever_open = false

func start_open():
	if was_ever_open:
		return
	was_ever_open = true
	$AnimatedSprite2D.play("default")
	#$"Icon".modulate = Color(0.5, 0.5, 0.5, 1.0)
	
func finish_open():
	$"CollisionShape2D".shape = null


func _on_body_entered(body):
	if body is DragonClass:
		body.shall_lose = true
		body.drown()


func _on_animated_sprite_2d_frame_changed():
	if $AnimatedSprite2D.frame == 4:
		finish_open()

extends RigidBody2D

const DragonClass = preload("res://dragon.gd")

func _on_area_2d_body_entered(body):
	$sprite_up.visible = false
	rotation = (body.position - position).angle()
	$sprite_up/Area2D.set_collision_layer_value(1, false)
	$sprite_up/Area2D.set_collision_mask_value(1, false)
	set_collision_layer_value(2, true)
	set_collision_mask_value(2, true)
	$sprite_down.visible = true
	$GPUParticles2D.emitting = true
	
	if body is DragonClass:
		body.shall_lose = true

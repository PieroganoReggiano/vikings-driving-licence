extends RigidBody2D

const DragonClass = preload("res://dragon.gd")
const FireballClass = preload("res://fireball.gd")

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
		
	if body is FireballClass:
		var node = get_parent()
		while node != null:
			var dragon = node.get_node("../Dragon")
			if dragon != null:
				dragon.shall_lose = true
				break
			node = node.get_parent()


extends AnimatedSprite2D

var fireball_cooldown = 3
var fireball_wait = 0

@export var fireball_scene : Resource

func _on_timer_timeout():
	if fireball_wait <= 0:
		fireball_wait = fireball_cooldown
		var direction = Vector2.DOWN.rotated(rotation)
		var fireball = fireball_scene.instantiate()
		fireball.position = position + direction * 48
		$"..".add_child(fireball)
		fireball.push(direction * 6)

func _physics_process(delta):
	fireball_wait -= delta
	if fireball_wait < 0:
		fireball_wait = -1

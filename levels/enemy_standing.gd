extends AnimatedSprite2D

@export var fireball_scene : Resource
@export var fireball_delay : float = 2

func _ready():
	$Timer.wait_time = fireball_delay
	$Timer.start(fireball_delay)
	animation = "idle"
	play()

func _on_timer_timeout():
	animation = "attack"
	play()

func _on_animation_looped():
	if animation == "attack":
		var direction = Vector2.DOWN.rotated(rotation)
		var fireball = fireball_scene.instantiate()
		fireball.position = position + direction * 48
		$"..".add_child(fireball)
		fireball.push(direction * 6)
		animation = "idle"
		play()

func _on_area_2d_area_entered(area):
	$explosion.emitting = true
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 0.5
	add_child(timer)
	timer.start(0.5)
	await timer.timeout
	queue_free()

extends RigidBody2D

var move_vector : Vector2 = Vector2.ZERO
var do_fire = false
var fireball_wait = -1

@export var default_resistance : float = 600.0
@export var sqrt_resistance : float = 9000.0
@export var forward_speed : float = 420000.0
@export var backward_speed: float = 160000.0
@export var turn_speed: float = 100.0
@export var fireball_scene : Resource
@export var fireball_cooldown : float = 1.0

var shall_win = false
var shall_lose = false

func set_vector(vec:Vector2):
	move_vector = vec

func set_animation_idle():
	var sprite = $"Sprite"
	if sprite.animation != "idle":
		sprite.play("idle")
	sprite.speed_scale = 1.0
	
func set_animation_walk(speed:float):
	var sprite = $"Sprite"
	if sprite.animation != "walk":
		sprite.play("walk")
	sprite.speed_scale = max(1.0, speed / 100.0)

func _physics_process(delta):
	var acceleration_force = Vector2.ZERO
	
	if move_vector.y < 0.0:
		acceleration_force += Vector2(0.0, forward_speed)
	
	if move_vector.y > 0.0:
		acceleration_force += Vector2(0.0, -backward_speed)
		
	if move_vector != Vector2.ZERO or linear_velocity.length() > 20.0:
		var walk_animation_speed = linear_velocity.length()
		set_animation_walk(walk_animation_speed)
	else:
		set_animation_idle()
		
	acceleration_force = acceleration_force.rotated(rotation)
	
	if (linear_velocity != Vector2.ZERO):
		acceleration_force += linear_velocity * default_resistance
		var sqrt_velocity = linear_velocity / sqrt(linear_velocity.length())
		acceleration_force += sqrt_velocity * sqrt_resistance
	
	apply_central_force(-acceleration_force)
	
	set_angular_velocity(turn_speed * move_vector.x * delta)
	
	handle_fire(delta)
	
	#rotation += (turn_speed * move_vector.x * delta)


func get_direction_vector():
	return Vector2(sin(rotation), -cos(rotation))

func handle_fire(delta):
	fireball_wait -= delta
	if fireball_wait < 0:
		fireball_wait = -1
	if not do_fire:
		return
	do_fire = false
	if fireball_wait > 0.0:
		return
	var direction = get_direction_vector()
	var fireball = fireball_scene.instantiate()
	fireball.position = position + direction * 48
	$"..".add_child(fireball)
	fireball.push(direction * 6)
	fireball_wait = fireball_cooldown
	

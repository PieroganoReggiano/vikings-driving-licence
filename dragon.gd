extends RigidBody2D

var move_vector : Vector2 = Vector2.ZERO
var do_fire = false
var fireball_wait = 0.5

@export var default_resistance : float = 600.0
@export var sqrt_resistance : float = 9000.0
@export var forward_speed : float = 420000.0
@export var backward_speed: float = 600000.0
@export var turn_speed: float = 200.0
@export var fireball_scene : Resource
@export var fireball_cooldown : float = 1.0

var shall_win = false
var shall_lose = false

func _ready():
	get_node("/root/Root").dragon = self

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
	move_vector = Vector2(Input.get_axis("forward", "backward"), Input.get_axis("left", "right"))
	if move_vector.x > 0:
		move_vector.y = -move_vector.y
	
	if Input.is_action_just_pressed("fire"):
		do_fire = true
	
	var acceleration_force = Vector2.ZERO
	
	if move_vector.x < 0.0:
		acceleration_force += Vector2(forward_speed, 0.0)
	
	if move_vector.x > 0.0:
		acceleration_force += Vector2(-backward_speed, 0.0)
	
	if move_vector != Vector2.ZERO or linear_velocity.length() > 20.0:
		var walk_animation_speed = linear_velocity.length()
		set_animation_walk(walk_animation_speed)
	else:
		set_animation_idle()
	
	acceleration_force = acceleration_force.rotated(rotation)
	
	linear_velocity = 0.8 * linear_velocity + 0.2 * linear_velocity.rotated(rotation-linear_velocity.angle())
	
	if (linear_velocity != Vector2.ZERO):
		acceleration_force -= linear_velocity * default_resistance
		var sqrt_velocity = linear_velocity / sqrt(linear_velocity.length())
		acceleration_force -= sqrt_velocity * sqrt_resistance
	
	apply_central_force(acceleration_force)
	
	set_angular_velocity(turn_speed * move_vector.y * delta)
	
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
	fireball.push(direction * 6 + linear_velocity/60)
	fireball_wait = fireball_cooldown
	

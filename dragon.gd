extends RigidBody2D

var move_vector : Vector2 = Vector2.ZERO
var requesting_fire = false
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
var grounded = false

func _ready():
	get_node("/root/Root").dragon = self
	$Sprite.play("idle")

func anim_idle():
	var sprite = $"Sprite"
	sprite.scale.x = 1.0
	if sprite.animation != "idle":
		sprite.play("idle")
	sprite.speed_scale = 1.0
	
func anim_walk(speed:float):
	var sprite = $"Sprite"
	sprite.scale.x = 1.0
	if sprite.animation != "walk":
		sprite.play("walk")
	sprite.speed_scale = max(1.0, speed / 100.0)
	
func anim_walk_turn(way:float, speed:float):
	var sprite = $"Sprite"
	if way * sprite.scale.x < 0.0 or sprite.animation != "walk_after_turn":
		sprite.play("walk_after_turn")
	sprite.scale.x = sign(way)
	sprite.speed_scale = max(1.0, speed / 100.0)
	
	
func anim_turn(way:float):
	var sprite = $"Sprite"
	if way * sprite.scale.x < 0.0 or sprite.animation != "turn_loop":
		sprite.play("turn_loop")
	sprite.scale.x = sign(way)
	sprite.speed_scale = 1.0
	
func anim_fire():
	var sprite = $"Sprite"
	sprite.scale.x = 1.0
	if sprite.animation != "attack_loop":
		sprite.play("attack_loop")
	sprite.speed_scale = 1.0

func _physics_process(delta):
	handle_cooldown(delta)
	handle_movement_and_physics(delta)
	handle_animation(delta)
	
	if grounded or shall_win:
		set_collision_layer_value(1, false)
		set_collision_layer_value(5, false)
		set_collision_layer_value(6, false)
		set_collision_layer_value(7, false)
		set_collision_mask_value(1, false)
		set_collision_mask_value(5, false)
		set_collision_mask_value(6, false)
		set_collision_mask_value(7, false)

func handle_movement_and_physics(_delta):
	var acceleration_force = Vector2.ZERO
	move_vector = Vector2.ZERO
	
		
	if not $Sprite.animation == "attack_loop" and not grounded and not shall_win:
		move_vector = Vector2(Input.get_axis("forward", "backward"), Input.get_axis("left", "right"))
		if Input.is_action_just_pressed("fire") and fireball_wait <= 0.0:
			requesting_fire = true
		
	if move_vector.x > 0:
		move_vector.y = -move_vector.y
	
	if move_vector.x < 0.0:
		acceleration_force += Vector2(forward_speed, 0.0)
	
	if move_vector.x > 0.0:
		acceleration_force += Vector2(-backward_speed, 0.0)
	
	acceleration_force = acceleration_force.rotated(rotation)
	
	linear_velocity = 0.8 * linear_velocity + 0.2 * linear_velocity.rotated(rotation-linear_velocity.angle())
	
	if (linear_velocity != Vector2.ZERO):
		var resistance_force = Vector2.ZERO
		var resistance_mult = 1.0
		if grounded or shall_win:
			resistance_mult = 18.0
		resistance_force += linear_velocity * default_resistance * resistance_mult
		var sqrt_velocity = linear_velocity / sqrt(linear_velocity.length())
		resistance_force += sqrt_velocity * sqrt_resistance * resistance_mult
		var resistance_force_overdrive = resistance_force.length() / mass / linear_velocity.length() * 0.1
		if resistance_force_overdrive > 1.0:
			resistance_force /= resistance_force_overdrive
		acceleration_force -= resistance_force
	
	if is_finite(acceleration_force.length()):
		apply_central_force(acceleration_force)
	
	set_angular_velocity(turn_speed * move_vector.y * 1.0/60.0)

func handle_animation(_delta):
	if $Sprite.animation == "attack_loop":
		return # whe fire, cannot do anything else
	var walk_animation_speed = linear_velocity.length() * 0.4
	if requesting_fire and fireball_wait <= 0.0:
		anim_fire()
		requesting_fire = false
	elif move_vector.x != 0.0 or linear_velocity.length() > 40.0:
		if move_vector.y != 0.0 and linear_velocity.length() < 350.0:
			anim_walk_turn(move_vector.y, walk_animation_speed)
		else:
			anim_walk(walk_animation_speed)
	elif move_vector.y != 0.0:
		anim_turn(move_vector.y)
	else:
		anim_idle()
	

func get_direction_vector():
	return Vector2(cos(rotation), sin(rotation))

func handle_cooldown(delta):
	fireball_wait -= delta
	if fireball_wait < 0:
		fireball_wait = -1

func do_fire():
	var direction = get_direction_vector()
	var fireball = fireball_scene.instantiate()
	fireball.position = position + direction * 48
	$"..".add_child(fireball)
	fireball.push(direction * 6 + linear_velocity/60)
	fireball_wait = fireball_cooldown
	


func _on_sprite_frame_changed():
	if $Sprite.animation == "attack_loop" and $Sprite.frame == 4:
		do_fire()


func _on_sprite_animation_looped():
	if $Sprite.animation == "attack_loop":
		$Sprite.play("idle")

func drown():
#	controls_locked = true
	$drown.emitting = true
	#var timer = Timer.new()
	#add_child(timer)
	grounded = true
	$Sprite.modulate = Color(0.7, 0.77, 0.77, 1.0)
	#timer.start(2)
	#await timer.timeout

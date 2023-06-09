extends RigidBody2D

var move_vector : Vector2 = Vector2.ZERO

@export var default_resistance : float = 4.0
@export var forward_speed : float = 2400.0
@export var backward_speed: float = 1200.0
@export var turn_speed: float = 100.0

func set_vector(vec:Vector2):
	move_vector = vec
	
func _physics_process(delta):
	var acceleration_force = Vector2.ZERO
	
	if move_vector.y < 0.0:
		acceleration_force += Vector2(0.0, forward_speed)
	
	if move_vector.y > 0.0:
		acceleration_force += Vector2(0.0, -backward_speed)
		
	acceleration_force = acceleration_force.rotated(rotation)
	
	acceleration_force += linear_velocity * default_resistance
	
	apply_central_force(-acceleration_force)
	
	set_angular_velocity(turn_speed * move_vector.x * delta)
	
	#rotation += (turn_speed * move_vector.x * delta)


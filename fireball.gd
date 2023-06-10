extends AnimatableBody2D

var velocity = Vector2.ZERO

func push(vec : Vector2):
	velocity = vec
	set_constant_angular_velocity(0)
	set_constant_linear_velocity(vec)
	rotation = atan2(vec.y, vec.x)
	
func _physics_process(delta):
	move_and_collide(velocity)

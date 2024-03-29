extends Area2D

var velocity = Vector2.ZERO
var time_left = 15.0

func push(vec : Vector2):
	velocity = vec
	#set_constant_angular_velocity(0)
	#set_constant_linear_velocity(vec)
	rotation = atan2(vec.y, vec.x)
	
func _ready():
	$"AnimatedSprite2D".play("idle")
	
func _physics_process(delta):
	#move_and_collide(velocity)
	position = position + velocity
	time_left -= delta
	if time_left < 0.0:
		$"..".remove_child(self)
		queue_free()


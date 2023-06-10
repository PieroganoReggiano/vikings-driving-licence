extends Node

@export var dragon_controller_path : String
@export var camera_path : String

var control
var camera

func is_forward():
	return Input.is_action_pressed("forward")
	
func is_backward():
	return Input.is_action_pressed("backward")
	
func get_forward_backward_axis():
	return Input.get_axis("backward","forward")
	
func is_turn_right():
	return Input.is_action_pressed("right")

func is_turn_left():
	return Input.is_action_pressed("left")
	
func is_firing():
	return Input.is_action_just_pressed("fire")
	
func get_turning_axis():
	return Input.get_axis("left","right")

func _process(delta):
	if (control == null):
		return
	
	control.set_vector(
		Vector2.UP * get_forward_backward_axis() +
		Vector2.RIGHT * get_turning_axis()
	)
	
	if is_firing():
		control.fire_fireball()
	
	#print(control.move_vector)

func _ready():
	control = get_node(dragon_controller_path)
	#print_debug("control: ", control, " (", dragon_controller_path, ")")
	camera = get_node(camera_path)

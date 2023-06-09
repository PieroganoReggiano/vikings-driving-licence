extends Node

@export var dragon_controller_path : String
@export var camera_path : String

var control
var camera

func is_forward():
	return Input.is_action_pressed("forward")
	
func is_backward():
	return Input.is_action_pressed("backward")
	
func is_turn_right():
	return Input.is_action_pressed("right")

func is_turn_left():
	return Input.is_action_pressed("left")

func _process(delta):
	if (control == null):
		return
		
	control.set_vector(
		Vector2.UP * float(is_forward()) +
		Vector2.DOWN * float(is_backward()) +
		Vector2.LEFT * float(is_turn_left()) +
		Vector2.RIGHT * float(is_turn_right())
	)
	#print(control.move_vector)

func _ready():
	control = get_node(dragon_controller_path)
	#print_debug("control: ", control, " (", dragon_controller_path, ")")
	camera = get_node(camera_path)

extends Node

# Input mapping for Xbox One controller
const AXIS_X = 2
const AXIS_Y = 3

# Mouse sensitivity for joystick movement
const SENSITIVITY = 1000

# Called when the node enters the scene tree for the first time
func _ready():
	pass

# Called every frame
func _process(delta):
	if "Xbox One Controller" == Input.get_joy_name(0):
		if Input.is_action_pressed("right_stick_right"):
			Input.warp_mouse_position(get_parent().get_global_mouse_position()+Vector2(SENSITIVITY, 0))
		if Input.is_action_pressed("right_stick_left"):
			Input.warp_mouse_position(get_parent().get_global_mouse_position()+Vector2(-SENSITIVITY, 0))
		if Input.is_action_pressed("right_stick_up"):
			Input.warp_mouse_position(get_parent().get_global_mouse_position()+Vector2(0, -SENSITIVITY))
		if Input.is_action_pressed("right_stick_down"):
			Input.warp_mouse_position(get_parent().get_global_mouse_position()+Vector2(0, SENSITIVITY))
		print(get_parent().get_global_mouse_position())

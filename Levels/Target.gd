extends KinematicBody2D


var using_mouse = true
var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_parent().get_node("Player").position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.get_last_mouse_speed().x > 0 or Input.get_last_mouse_speed().y>0:
		position = get_global_mouse_position()
	else:
		print(1)
		if Input.is_action_pressed("target_down"):
			print(2)
			position.y += 10
		if Input.is_action_pressed("target_up"):
			position.y -= 10
		if Input.is_action_pressed("target_left"):
			position.x -= 10
		if Input.is_action_pressed("target_right"):
			position.x += 10
	

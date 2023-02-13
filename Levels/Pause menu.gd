extends MarginContainer

var paused = false


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause") or $Resume.pressed:
		if paused == false:
			get_parent().get_tree().paused = true
			paused = true
			visible = true
		else:
			get_parent().get_tree().paused = false
			paused = false
			visible = false
	# Always be at the center of the screen and scale with the camera
	rect_position = Vector2(get_parent().get_node("Player").position.x - 100, get_parent().get_node("Player").position.y - 100)
	rect_scale = Vector2(get_parent().get_node("Camera2D").zoom.x * 3, get_parent().get_node("Camera2D").zoom.y * 3)

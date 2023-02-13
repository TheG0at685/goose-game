extends Camera2D



var max_roll = 10
var max_offset = Vector2(5, 5)
var amount = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Area2D.position = get_parent().get_node("Player").position - position
	for door in get_parent().level_instance.doors:
		if not $Area2D.overlaps_area(door):
			position = get_parent().get_node("Player").position
		else:
			print(1)
	if not Input.is_action_pressed("fire"):
		defualt()
	
		
func shake():
	rotation = max_roll * amount * rand_range(-1, 1)
	offset.x = max_offset.x * amount * rand_range(-1, 1)
	offset.y = max_offset.y * amount * rand_range(-1, 1)


		
func defualt():
	rotation = 0.0

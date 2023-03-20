extends Camera2D




var BASE_POS = position
var _duration = 0.0
var _period_in_ms = 0.0
var _amplitude = 0
var _timer = 0.0
var _last_shook_timer = 0
var _previous_x = 0.0
var _previous_y = 0.0
var _last_offset = Vector2(0, 0)


var camera_speed = 14

var shaking = false

export var glide_to_player = false

onready var player = get_parent().get_node("Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Make the camera move faster the further it is from the player
	camera_speed = position.distance_to(player.position)/50
	if glide_to_player:
		if not $Area2D.overlaps_body(player):
			if position.x < player.position.x:
				position.x += camera_speed
			elif position.x > player.position.x:
				position.x -= camera_speed
			if position.y < player.position.y-75:
				position.y += camera_speed
			elif position.y > player.position.y+75:
				position.y -= camera_speed
	else:
		position = player.position
			
	if not Input.is_action_pressed("fire"):
		defualt()
		
	if shaking:
		if _timer > 0:
			_timer -= 1
			position.x += rand_range(-_amplitude, _amplitude)
			position.y += rand_range(-_amplitude, _amplitude)
			rotation_degrees += rand_range(-_amplitude, _amplitude)
		else:
			shaking = false
		
		
		
		
	
		
# Kick off a new screenshake effect.
func shake(duration, frequency, amplitude):
	_timer = duration
	_amplitude = amplitude
	shaking = true
	


		
func defualt():
	rotation = 0.0
	

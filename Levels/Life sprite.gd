extends Sprite


var life_id

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = 75*life_id
	if get_parent().get_parent().player.lives >= life_id:
		self_modulate.r = 255
		self_modulate.g = 255
		self_modulate.b = 255
	else:
		self_modulate.r = 0
		self_modulate.g = 0
		self_modulate.b = 0

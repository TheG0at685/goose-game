extends TileMap


var timer = 120
var on = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer > 0:
		timer -= 1
	if timer == 0:
		timer = 120
		if on:
			on = false
		else:
			on = true
	if on:
		visible = true
		position.y = 0
	else:
		visible = false
		position.y = 50000000


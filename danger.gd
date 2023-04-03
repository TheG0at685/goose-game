extends TileMap


var pos = 0
var moving = "left"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving == "left":
		position.x -= 1
		pos -= 1
		if pos < -100:
			moving = "right"
	else:
		position.x += 1
		pos += 1
		if pos > 100:
			moving = "left"
	

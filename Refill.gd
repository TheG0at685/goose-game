extends Area2D


var timer = 120


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible == false:
		timer -= 1
	if timer == 0:
		timer = 120
		visible = true

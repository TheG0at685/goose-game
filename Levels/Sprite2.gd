extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	scale = Vector2(0.01, 0.01)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show():
	if scale.x < 1:
		visible = true
		scale.x += 0.01
		scale.y += 0.01
	else:
		scale = Vector2(0.01, 0.01)
		visible = false

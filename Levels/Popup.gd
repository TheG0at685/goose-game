extends Popup


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show_diolauge(name, image, diolauge):
	visible = true
	$Name.text = name
	$Sprite.texture = image
	$Diolauge.text = diolauge

func hide_diolauge():
	# Simple as that. This funtion is purley to improve organiation and readablity
	visible = false

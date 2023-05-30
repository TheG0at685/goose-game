extends Light2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Only shine when inside a temple
	if get_tree().current_scene.get_node("ParallaxBackground2").mode == "temple":
		enabled = true
	else:
		enabled = false


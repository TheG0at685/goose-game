extends CanvasModulate


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_tree().current_scene.get_node("ParallaxBackground2").mode == "temple":
		color.r8 = 0
		color.g8 = 0
		color.b8 = 0
	else:
		color.r8 = 255
		color.g8 = 255
		color.b8 = 255

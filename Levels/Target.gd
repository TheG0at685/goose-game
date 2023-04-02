extends KinematicBody2D


var using_mouse = true
var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_parent().get_node("Player").position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_global_mouse_position()

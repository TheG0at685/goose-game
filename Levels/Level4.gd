extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# Make sure that the tutorial animation stops playing
	get_tree().current_scene.get_node("Player/Thought").play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

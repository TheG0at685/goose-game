extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().current_scene.get_node("Player/Thought").play("Wall jump")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends KinematicBody2D


onready var camera_pos = $Camera2D.position
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().current_scene.get_node("Player").has_gun = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

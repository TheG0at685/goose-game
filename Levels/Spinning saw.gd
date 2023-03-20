tool
extends KinematicBody2D


export var spin_speed = 1.0
export var length = 300


# Called when the node enters the scene tree for the first time.
func _ready():
	$MeshInstance2D.scale.x = length
	$MeshInstance2D.position.x = length/2
	$Item.position.x = length


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation_degrees += spin_speed

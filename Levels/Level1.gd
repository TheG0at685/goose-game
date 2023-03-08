extends KinematicBody2D


onready var doors = [$right]

var meteorite = load("Meteorite.tscn")
var meteorite_timer = 600
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

extends KinematicBody2D


onready var doors = [$right]
var mummie = load("res://mummie.tscn")

var meteorite = load("Meteorite.tscn")
var meteorite_timer = 600

var level_parts = [load("res://Levels/level parts/Level part 1.tscn")]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

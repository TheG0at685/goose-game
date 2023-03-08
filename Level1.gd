extends KinematicBody2D


onready var doors = [$right]
var mummie = load("res://mummie.tscn")

var meteorite = load("Meteorite.tscn")
var meteorite_timer = 600

var level_parts = [load("res://Levels/level parts/Level part 1.tscn")]
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for l in range(-1, 1):
		for i in range(20):
			var new_part = level_parts[rand_range(0, len(level_parts)-1)].instance()
			add_child(new_part)
			new_part.position = Vector2(1088*i + 1088, l*1088)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

extends StaticBody2D


var level_parts = [load("res://Levels/level parts/Level part 1.tscn")]

var spawned_levels = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.distance_to(get_tree().current_scene.get_node("Player").position) < 1000 and not spawned_levels:
		
		

extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if overlaps_body(get_tree().current_scene.get_node("Player")) and not get_tree().current_scene.get_node("Player").godmode:
		get_tree().current_scene.get_node("Player").position = Vector2(0, 0)
		get_tree().current_scene.get_node("Player").health = -1

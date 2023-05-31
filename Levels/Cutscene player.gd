extends Area2D


var played = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if overlaps_body(get_tree().current_scene.get_node("Player")) and not played:
		played = true
		get_tree().current_scene.get_node("UI/Cutscene player").play()
		get_tree().paused = true

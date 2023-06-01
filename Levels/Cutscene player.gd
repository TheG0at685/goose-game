extends Area2D


var played = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_Timer_timeout():
	# Check if we're in the cutscene area every second
	if overlaps_body(get_tree().current_scene.get_node("Player")) and not played:
		played = true
		get_tree().current_scene.get_node("UI/Cutscene player").play()
		get_tree().paused = true
		get_tree().current_scene.current_song = "res://Assets/sounds/The deadly temple.wav"
		get_tree().current_scene.play()

extends Area2D


export var play = "Gun jump"
export var release_input = "fire"
var played = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (not played) and overlaps_body(get_tree().current_scene.get_node("Player")):
		get_tree().paused = true
		get_tree().current_scene.get_node("Player/Thought").play(play)
		if play == "Gun jump":
			get_tree().current_scene.get_node("Player").has_gun = true
		if Input.is_action_just_pressed(release_input):
			played = true
				
			if play == "Gun jump":
				get_tree().current_scene.get_node("Camera2D").shake(60, 0, 15)
				get_tree().current_scene.get_node("Player").fire_gun(get_tree().current_scene.get_node("Player").position.x - 500, get_tree().current_scene.get_node("Player").position.y + 500)
				get_tree().current_scene.get_node("Player/Thought").play("defualt")
	else:
		if not get_tree().current_scene.menu_instance.paused:
			get_tree().paused = false
	


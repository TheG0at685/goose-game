extends RichTextLabel


func _ready():
	if not get_tree().current_scene.shown_gun_tutorial:
		get_tree().paused = true
	else:
		visible = false
	
func _process(delta):
	if not get_tree().current_scene.shown_gun_tutorial:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().current_scene.shown_gun_tutorial = true
			get_tree(). paused= false
			visible=false

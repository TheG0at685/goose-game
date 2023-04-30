extends CanvasLayer

var can_show = true
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	visible = true
	get_parent().current_song = "res://Assets/sounds/The Amazing Goose Game Main Theme(AKA Balled of the Goose).wav"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_show:
		if $Sprite.modulate.a8 < 200:
			$Sprite.modulate.a8 += 1
			$Sprite/Button.visible = false
		else:
			$Sprite/Button.visible = true




func _on_Button_pressed():
	get_parent().pause_mode = Node.PAUSE_MODE_INHERIT
	$AudioStreamPlayer2D.play()
	get_tree().paused = false
	visible = false
	get_parent().get_node("UI").visible = true
	
	

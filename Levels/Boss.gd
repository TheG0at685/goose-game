extends Node2D

var phase


# Called when the node enters the scene tree for the first time.
func _ready():
	next_phase(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(position, get_parent())


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "arm smash":
		get_tree().current_scene.get_node("Camera2D").shake(160, 0, 20)
	if anim_name == "flash":
		get_tree().current_scene.get_node("Player").position = Vector2(-10200, -1625)
		next_phase(phase+1)
		
func next_phase(phase_number):
	phase = phase_number
	$AnimationPlayer.play("arm smash")

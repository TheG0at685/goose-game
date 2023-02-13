extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show():
	if $Credits/MeshInstance2D.modulate.a8 < 255:
		$Credits/MeshInstance2D.modulate.a8 += 1
	elif $Credits/Sprite.modulate.a8 < 255:
		$Credits/Sprite.modulate.a8 += 1
	else:
		get_tree().paused = true
	if not $AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()

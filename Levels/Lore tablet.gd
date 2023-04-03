extends StaticBody2D

export var image = preload("res://Assets/Images/falling star.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	$Text/Node2D.modulate.a8 = 0
	$Text/Node2D/TextureRect.texture = image


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Area2D.overlaps_body(get_tree().current_scene.get_node("Player")) and Input.is_action_just_pressed("ui_accept") and not $AnimationPlayer.is_playing():
		if $Text/Node2D.modulate.a8 == 255:
			$AnimationPlayer.play("change visibility")
		else:
			$AnimationPlayer.play_backwards("change visibility")
	
	if not $Area2D.overlaps_body(get_tree().current_scene.get_node("Player")) and $Text/Node2D.modulate.a8 == 255:
		$AnimationPlayer.play("change visibility")
		

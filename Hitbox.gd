extends Area2D

var killable = true
onready var player = get_tree().current_scene.get_node("Player")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if overlaps_body(player):
		modulate.a8 = 255
	else:
		modulate.a8 = 0
	if modulate.a8 == 255:
		for bullet in get_tree().get_nodes_in_group("bullets"):
			if killable:
				if overlaps_area(bullet.get_node("Collision")):
					get_parent().get_node("AnimationPlayer").play("flash")
					killable = false
		if not killable:
			for b in get_tree().get_nodes_in_group("bullets"):
				b.queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "flash":
		killable = true
		get_parent().get_node("Laser/AnimationPlayer").stop()
		get_parent().get_node("Laser").fire_laser()
		

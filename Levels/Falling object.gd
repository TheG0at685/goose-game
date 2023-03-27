tool
extends RigidBody2D

export var fall_on_touch = false
export var collision_size = Vector2(1, 1)
export var delay = 0.0
var falling = false
var camera_shook = false
# We need to check if it is on the ground
var last_y_pos = position.y

# There has to be a better way of doing this, right?
var same_y_pos_in_a_row = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	gravity_scale = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not Engine.is_editor_hint():
		for bullet in get_tree().get_nodes_in_group("bullets"):
			print(get_tree().get_nodes_in_group("bullets"))
			if $Area2D.overlaps_area(bullet.get_node("Collision")):
				if delay > 0:
					yield(get_tree().create_timer(delay),"timeout")
				gravity_scale = 15
				if not falling:
					linear_velocity = Vector2(0, -1)
				falling = true
		if fall_on_touch and $Area2D.overlaps_body(get_tree().current_scene.get_node("Player")):
			if delay > 0:
				yield(get_tree().create_timer(delay),"timeout")
			gravity_scale = 15
			if not falling:
				linear_velocity = Vector2(0, -1)
			falling = true
			
			
			
		if $Bottom.overlaps_body(get_tree().current_scene.get_node("Player")):
			get_tree().current_scene.get_node("Player").health = -1
			get_tree().current_scene.get_node("Player").die()
			
		if not camera_shook:
			$Particles2D.emitting = true
		else:
			$Particles2D.emitting = false
		
		
			
		

		
	$Area2D.scale = collision_size


func _on_Bottom_body_entered(body):
	if not body == get_tree().current_scene.get_node("Player") and not body == self and not camera_shook:
		get_tree().current_scene.get_node("Camera2D").shake(40*((scale.x + scale.y)/2), 0, 30*((scale.x + scale.y)/2))
		camera_shook = true

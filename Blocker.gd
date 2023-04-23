"""Very similar to Falling object except it is triggered by a signal rather then the player
Could have probably just adjusted the falling object code, but oh well. Sorry to whoever has to work on this
Oh wait... It's me
'"""

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
	falling = false
	gravity_scale = 0
	linear_velocity = Vector2(0, 0)
	$CollisionShape2D.scale = Vector2(50, 50)
	$Bottom.scale = Vector2(5, 5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not Engine.is_editor_hint():
		if $Bottom.overlaps_body(get_tree().current_scene.get_node("Player")):
			get_tree().current_scene.get_node("Player").health = -1
			get_tree().current_scene.get_node("Player").die()
			
		if not camera_shook:
			$Particles2D.emitting = true
		else:
			$Particles2D.emitting = false
		if is_queued_for_deletion():
			
			print(is_queued_for_deletion())
		
		
			
		

		
	$Area2D.scale = collision_size


func _on_Bottom_body_entered(body):
	if not body == get_tree().current_scene.get_node("Player") and not body == self and not camera_shook:
		get_tree().current_scene.get_node("Camera2D").shake(40*((scale.x + scale.y)/2), 0, 30*((scale.x + scale.y)/2))
		camera_shook = true
		
func fall():
	if not falling:
		gravity_scale = 15
		linear_velocity = Vector2(0, -1)
		falling = true

extends KinematicBody2D


var falling = false
var shot = false
var gravity = 0
var touched_ground = false
# Some collisions don't seem to be detected by is_on_floor() so this will check if falling object has been moved on the y
var prev_y_pos = position.y
export var fall_on_touch = false
export var wait_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for bullet in get_tree().current_scene.player_bullets:
		if $Area2D.overlaps_area(bullet.get_node("Collision")) or ($Area2D.overlaps_body(get_tree().current_scene.get_node("Player")) and fall_on_touch):
			shot = true
			yield(get_tree().create_timer(wait_time), "timeout")

		
	if shot:
		move_and_slide(Vector2(0, gravity), Vector2(0, -1))
		if not is_on_floor() or prev_y_pos == position.y:
			gravity += 5
		else:
			touched_ground = true
			gravity = 0
		$Particles2D.emitting = false
	else:
		$Particles2D.emitting = true
		
		
		
		
		
	



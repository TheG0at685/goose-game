tool
extends KinematicBody2D


var falling = false
var shot = false
var gravity = 0
var touched_ground = false
var shook = false
# Some collisions don't seem to be detected by is_on_floor() so this will check if falling object has been moved on the y
var prev_y_pos = position.y
export var fall_on_touch = false
export var wait_time = 0.0
export var mode = {"desert": true, "temple": false}
export var Trigger_height = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Wait timer".wait_time = wait_time
	$Area2D/CollisionShape2D.scale.y = Trigger_height


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		$Area2D/CollisionShape2D.scale.y = Trigger_height
	if not Engine.is_editor_hint():
		if mode["desert"]:
			$TileMap.visible = true
		else:
			$TileMap.visible = false
		
		if mode["temple"]:
			$TileMap2.visible = true
		else:
			$TileMap2.visible = false
		
		for bullet in get_tree().current_scene.player_bullets:
			if $Area2D.overlaps_area(bullet.get_node("Collision")):
				if wait_time > 0:
					$"Wait timer".start()
				else:
					shot = true
		if $Area2D.overlaps_body(get_tree().current_scene.get_node("Player")) and fall_on_touch:
			if wait_time > 0:
				$"Wait timer".start()
			else:
				shot = true


		
		if shot:
			move_and_slide(Vector2(0, gravity), Vector2(0, -1))
			# Kill the player if it has landed on them
			if $Area2D.overlaps_body(get_tree().current_scene.get_node("Player")) and abs(position.y - get_tree().current_scene.get_node("Player").position.y) < 200 and position.y < get_tree().current_scene.get_node("Player").position.y:
				get_tree().current_scene.get_node("Player").health = -1
			if not is_on_floor() or prev_y_pos == position.y:
				gravity += 5
			else:
				touched_ground = true
				gravity = 0
				if not shook:
					get_tree().current_scene.get_node("Camera2D").shake(60, 0, 20)
					shook = true
			$Particles2D.emitting = false
		else:
			$Particles2D.emitting = true
		
		
		
		
		
	




func _on_Wait_timer_timeout():
	shot = true

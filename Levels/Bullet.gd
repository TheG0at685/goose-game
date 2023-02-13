extends KinematicBody2D


var velocity = Vector2()
var speed = 500

# determines if it is the player or the enemy bullet
var side


var current_level
# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2()
	velocity = Vector2(-speed, 0).rotated(rotation)
	velocity = move_and_slide(velocity)
	
	if $Collision.overlaps_body(get_parent().get_node("Player").current_level.get_node("TileMap")):
		# If touching the map delete the instance and its object in the level array
		if side == "player":
			get_parent().player_bullets.erase(self)
		else:
			get_parent().enemy_bullets.erase(self)
		queue_free()
		
	if side == "enemy":
		# Logic for specifcily enenmy bullets
		if $Collision.overlaps_body(get_parent().get_node("Player")):
			get_parent().enemy_bullets.erase(self)
			queue_free()
	
	if side == "player":
		# Logic for player bullets
		for enemy in get_parent().enemys:
			if $Collision.overlaps_area(enemy.get_node("Collision")):
				get_parent().player_bullets.erase(self)
				queue_free()
		if get_parent().get_node("Player").godmode:
			scale = Vector2(100, 100)
			speed = 2500
		else:
			scale = Vector2(2, 2)
			speed = 500
				
	# Get rid of the bullet if it's to far away to prevent lag
	if position.distance_to(get_parent().get_node("Player").position) > 4000:
		if side == "enemy":
			get_parent().enemy_bullets.erase(self)
		else:
			get_parent().player_bullets.erase(self)
		queue_free()


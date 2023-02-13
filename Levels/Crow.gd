extends KinematicBody2D


onready var player = get_tree().root.get_child(0).get_node("Player")
var attacking = false

var attack = false

var health = 100

var added = false


var speed = rand_range(1, 3)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not added:
		# add to enemy list
		get_tree().root.get_child(0).enemys.append(self)
		added = true
		
	if position.distance_to(player.position) < 1000:
		attack = true
	else:
		attack = false
	move()
	shot()

func move():
	if not attacking:
		rotation_degrees = 0
		# Move away if the player is to close
		$bird.animation = "default"
		modulate.r = 1
		if between(0, 200, position.distance_to(player.position)):
			if position.x > player.position.x:
				position.x += 1 * speed
			else:
				position.x -= 1 * speed
			if position.y > player.position.y:
				position.y += 1 * speed
			else:
				position.y -= 1 * speed
		if between(200, 1000, position.distance_to(player.position)):
			if position.x > player.position.x:
				position.x -= 1 * speed
			else:
				position.x += 1 * speed
			if position.y > player.position.y:
				position.y -= 1 * speed
			else:
				position.y += 1 * speed
	else:
		modulate.r = 100
		$bird.animation = "attack"
		look_at(player.position)
		if position.x > player.position.x:
			position.x -= 3 * speed
		else:
			position.x += 3 * speed
		if position.y > player.position.y:
			position.y -= 3 * speed
		else:
			position.y += 3 * speed
				
	if position.x > player.position.x:
		$bird.flip_h = false
	else:
		$bird.flip_h = true
	
func shot():
	# Checks if the bird has been shot
	for bullet in get_tree().root.get_child(0).player_bullets:
		if $Collision.overlaps_area(bullet.get_node("Collision")):
			health -= player.strength
			# Push the bird back
			if bullet.position.x < position.x:
				position.x += 8
			else:
				position.x -= 8
			if bullet.position.y < position.y:
				position.y += 8
			else:
				position.y -= 8
	if health < 0:
		get_tree().root.get_child(0).enemys.erase(self)
		queue_free()
	
		
	
	
func between(num1, num2, num3):
	if num3 > num1 and num3 < num2:
		return true
	else:
		return false



func _on_attack_cooldown_timeout():
	attacking = true
	$"attack cooldown".stop()
	$"attack length".start()
	$AudioStreamPlayer2D.play()
	



func _on_attack_length_timeout():
	attacking = false
	$"attack length".stop()
	$"attack cooldown".wait_time = rand_range(4, 6)
	$"attack cooldown".start()

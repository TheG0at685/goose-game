extends KinematicBody2D


onready var player = get_tree().root.get_child(0).get_node("Player")
var attacking = false

var attack = false

var health = 100

var added = false


var speed = 150

var gravity = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not added:
		# add to enemy list
		get_tree().root.get_child(0).enemys.append(self)
		added = true
		
	if position.y >= 2000:
		get_tree().root.get_child(0).enemys.erase(self)
		queue_free()
		
		
	move()
	shot()
	animation()
	attack()

func move():
	if is_on_floor():
		gravity = 0
	else:
		gravity += 1
	if position.distance_to(player.position) < 1000 and not attacking:
		if position.x > player.position.x:
			move_and_slide(Vector2(speed, 0), Vector2(0, -1))
		else:
			move_and_slide(Vector2(-speed, 0), Vector2(0, -1))
	look_at(player.position)
	if between(-90, 90, rotation_degrees):
		scale.x = -0.75
		scale.y = 0.75
	else:
		scale.x = 0.75
		scale.y = 0.75
	rotation_degrees = 0
		
	
	move_and_slide(Vector2(0, gravity), Vector2(0, -1))
		
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
	
		
func animation():
	if not attacking:
		if position.distance_to(player.position) < 1000:
			$AnimationPlayer.play("walk")
		else:
			$AnimationPlayer.play("RESET")
	else:
		$AnimationPlayer.play("attack")
	
func between(num1=1, num2=2, num3=1.5):
	if num3 > num1 and num3 < num2:
		return true
	else:
		return false

func attack():
	if attacking and $"attack length".time_left < 1:
		if scale.x == -0.75:
			position -= Vector2(speed*3, speed)/200
			print("WEEE")
		else:
			position += Vector2(-speed*3, speed)/200
		
func _on_attack_cooldown_timeout():
	attacking = true
	$"attack cooldown".stop()
	$"attack length".start()
	



func _on_attack_length_timeout():
	attacking = false
	$"attack length".stop()
	$"attack cooldown".wait_time = rand_range(4, 6)
	$"attack cooldown".start()

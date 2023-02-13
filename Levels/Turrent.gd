extends KinematicBody2D


var gun_cooldown = 60
var can_shoot = true



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.distance_to(get_parent().get_node("Player").position) < 1000:
		look_at(get_parent().get_node("Player").position)
		shoot()
		die()
		
		
func shoot():
	if can_shoot:
		var bullet = load("res://Bullet.tscn")
		var bullet_instance = bullet.instance()
		get_parent().add_child(bullet_instance)
		bullet_instance.side = "enemy"
		get_parent().enemy_bullets.append(bullet_instance)
		bullet_instance.position = position
		bullet_instance.look_at(get_parent().get_node("Player").position)
		bullet_instance.rotation_degrees += 180 + rand_range(-5, 5)
		can_shoot = false
	if can_shoot == false and gun_cooldown > 0:
		gun_cooldown -= 1
	if gun_cooldown <= 0:
		gun_cooldown = 60
		can_shoot = true

		
func die():
	# Die if they get hit by a bullet
	for bullet in get_parent().player_bullets:
		if $Collision.overlaps_area(bullet.get_node("Collision")):
			if get_parent().get_node("Player").health < 85:
				get_parent().get_node("Player").health += 15
			get_parent().enemys.erase(self)
			queue_free()

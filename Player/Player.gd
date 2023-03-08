extends KinematicBody2D

var motion=Vector2(0,0)
const UP=Vector2(0,-1)
var SPEED=400
const GRAVITY=51
const JUMP_SPEED=1200
const JUMP_SUBLIMIT = 80
const WORLD_LIMIT=300000000000
const MAX_BULLETS = 3
const GUN_STRENGTH = 1.5
var jump_count=0
var wall_slide_speed=0
var wall_slide_max=5
var is_working = true
var earlyjump = false 
var can_jump = false
var can_wall_jump = false

var godmode = false

var left = "left"
var right = "right"
var jump = "jump"
var facing = "right"

var gun_shots = 10
var can_fire = true
var reloading = false

var health = 100

var respawn = Vector2()

var strength = 10


var current_level

var hurt = false


var has_wall_jump = true
var max_jump_count = 1
var has_gun = true
var critical_chance = 0


var lives = 5
# A safe position the player will teleport to when hurt by spikes or other completly harmless inanimite objects
var safe_spot = Vector2()


var paused = false

var max_jump = 1 

var current_weapon = "normal"

func _ready():
	pass
	
func _physics_process(delta):
	# Make sure the player level aligns with the actual level
	current_level = get_parent().level_instance
	
	# These funtions trigger every frame for movment, animation, etc 
	apply_gravity()
	
	move_and_slide(motion, UP)
	up_collision()
	side_collision()
	if not paused:
		movement(left,right)
		jumping(jump,left,right)
		jump_breaker(jump)
		early_jump(jump,left,right)
		coyote_jump()
		animate(left,right)
	next_level(1)
	if Input.is_action_just_pressed("god_mode"):
		if godmode:
			godmode = false
		else:
			godmode = true
	if godmode:
		god_mode()
		
	if motion.y > 0:
		# only let the player fire if we are falling
		gun()
	die()
	$AnimatedSprite/Gun_body.look_at(get_parent().get_node("Target").position)

func god_mode():
	has_gun = true
	if not $AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()
	motion.x = 0
	motion.y = 10
	can_fire = true
	gun_shots = 10000
	if Input.is_action_pressed("jump"):
		position.y -= 10
	if Input.is_action_pressed("down"):
		position.y += 10
	if Input.is_action_pressed("right"):
		position.x += 10
	if Input.is_action_pressed("left"):
		position.x -= 10
		get_parent().change_level(Vector2(0, 0))
	if Input.is_key_pressed(KEY_1):
		get_parent().level = 1
		get_parent().change_level(Vector2(0, 0))
	if Input.is_key_pressed(KEY_2):
		get_parent().level = 2
		get_parent().change_level(Vector2(0, 0))
	if Input.is_key_pressed(KEY_3):
		get_parent().level = 3
		get_parent().change_level(Vector2(0, 0))
	if Input.is_key_pressed(KEY_4):
		get_parent().level = 4
		get_parent().change_level(Vector2(0, 0))
	if Input.is_key_pressed(KEY_5):
		get_parent().level = 5
		get_parent().change_level(Vector2(0, 0))
	if Input.is_key_pressed(KEY_6):
		get_parent().level = 6
		get_parent().change_level(Vector2(0, 0))
	if Input.is_key_pressed(KEY_7):
		get_parent().level = 7
		get_parent().change_level(Vector2(0, 0))
	if Input.is_key_pressed(KEY_8):
		get_parent().level = 8
		get_parent().change_level(Vector2(0, 0))
	health = 100
		
	
		
func gun():
	if Input.is_action_just_pressed("fire") and gun_shots > 0 and can_fire and has_gun:
		get_tree().current_scene.get_node("Camera2D").shake()
		if gun_shots == MAX_BULLETS:
			motion.y = 0
		fire_gun(get_global_mouse_position().x, get_global_mouse_position().y)
		gun_shots -= 1
	if gun_shots < 1:
		get_tree().current_scene.get_node("Camera2D").position = Vector2(0, 0)
		get_tree().current_scene.get_node("Camera2D").rotation = 0
		reloading = true
		can_fire = false
	if can_fire == false and gun_shots > MAX_BULLETS-1:
		can_fire = true
	if reloading:
		gun_shots += 0.1
		if gun_shots > MAX_BULLETS-0.1:
			reloading = false
	# Cycle through the refills. If touching, refill ammo and delete the refill
	for refill in get_parent().refills:
		if $Collision.overlaps_area(refill.get_node("Area2D")):
			can_fire = true
			gun_shots = MAX_BULLETS
	if is_on_floor() or is_on_wall() and gun_shots < MAX_BULLETS:
		gun_shots = MAX_BULLETS

		

		


func up_collision():
	if is_on_ceiling():
		motion.y=1
		#if player bumps its head to ceiling, it will start to fall
		
func side_collision():
	#this function makes player stick to wall, also it stops player running animations when it hits a wall
	if $AnimatedSprite.animation=="wallslide":
		if is_on_wall():
			if $AnimatedSprite.flip_h:
				motion.x = 1
			elif not $AnimatedSprite.flip_h:
				motion.x = -1
			can_wall_jump = true
			yield(get_tree().create_timer(0.1),"timeout")
			can_wall_jump = false
	else:
		if is_on_wall():
			motion.x=0
			
			
func apply_gravity():
	if is_on_floor() and motion.y > 0:
		jump_count=max_jump_count
		motion.y=1
	elif is_on_wall() and motion.y > 0 and has_wall_jump:
		if wall_slide_speed < wall_slide_max:
			motion.y += 1
			wall_slide_speed=motion.y
		else:
			wall_slide_speed=wall_slide_max
			motion.y += 1
	else:
		motion.y+=GRAVITY
		can_jump = false
		
func movement(left,right):
	if Input.is_action_pressed(left) and not Input.is_action_pressed(right):
		left()
	elif Input.is_action_pressed(right) and not Input.is_action_pressed(left):
		right()
	#this part makes player slide rather than stop instantly
	elif motion.x>0 and is_on_floor():
		motion.x = clamp(motion.x - 50, 0, SPEED)
	elif motion.x<0 and is_on_floor():
		motion.x = clamp(motion.x + 50, -SPEED, 0)
		
		
func left():
	facing = "left"
	if motion.x <= -SPEED:
		motion.x = -SPEED
	else:
		if is_on_wall() and $AnimatedSprite.animation == "wallslide":
			if motion.x == 1:
				yield(get_tree().create_timer(0.1),"timeout")
				motion.x -= 50
		else:
			motion.x-=50
			
		
func right():
	facing = "right"
	if motion.x >= SPEED:
		motion.x = SPEED
	else:
		if is_on_wall() and $AnimatedSprite.animation == "wallslide":
			if motion.x == -1:
				yield(get_tree().create_timer(0.1),"timeout")
				motion.x += 50
		else:
			motion.x+=50
func jumping(jump,left,right):
	if jump_count > 0:
		can_jump = true
	if Input.is_action_just_pressed(jump) or earlyjump:
		#earlyjump variable here is makes sure player jumps even if we press slightly early
			if is_on_floor() or can_jump:
				$AnimatedSprite.stop()
				$AnimatedSprite.frame = 0
				$AnimatedSprite.play("jump")
				
				motion.y = -JUMP_SPEED
				jump_count-=1
			elif $AnimatedSprite.animation == "wallslide" and can_wall_jump and has_wall_jump:
				if not is_on_floor():
					if $AnimatedSprite.flip_h:
						motion.y = -JUMP_SPEED*(1)
						motion.x = -SPEED
					else:
						motion.y = -JUMP_SPEED*(1)
						motion.x = SPEED
					#this part makes player jump from walls to right direction
				
func jump_breaker(jump):
	#this code adjusts the jump height by how much we hold jump key
	if motion.y < -JUMP_SUBLIMIT and Input.is_action_just_released(jump):
		motion.y = motion.y/5
				
func early_jump(jump,left,right):
	if jump_count == 0 and Input.is_action_just_pressed(jump):
		if not is_on_floor():
			if not is_on_wall():
				#if player is in air and jump button is pressed while it has no jumps left. Earlyjump activates
				earlyjump = true
				yield(get_tree().create_timer(0.1),"timeout")
				earlyjump = false
				
func coyote_jump():
	if is_on_floor() and not $Collision.overlaps_body(current_level.get_node("Danger")):
		# Set this position to a safe position
		safe_spot = position
		can_jump = true
		
		$CoyoteTimer.start()

func _on_CoyoteTimer_timeout():
	can_jump = false

func animate(left,right):
	#animation codes are important because I use some of them to determine how player will act when we press a button
	#some jump animations are in jump function
	if is_working:
		if motion.y < -51 and not is_on_wall():
			if is_on_floor():
				$AnimatedSprite.play("jump")
		elif motion.x != 0 and not is_on_wall():
			$AnimatedSprite.get_sprite_frames().set_animation_speed("walk", 24)
			if facing=="left" and is_on_floor():
				if Input.is_action_pressed(left):
					$AnimatedSprite.flip_h=true
					$AnimatedSprite.play("walk")
					$AnimatedSprite/Gun_body/Gun.flip_h=false
					$AnimatedSprite/Gun_body/Gun.flip_v=false
					$AnimatedSprite/Gun_body.position = Vector2(-70, 0)
				else:
					$AnimatedSprite.play("default")
			elif facing=="right" and is_on_floor():
				if Input.is_action_pressed(right):
					$AnimatedSprite.flip_h=false
					$AnimatedSprite.play("walk")
					$AnimatedSprite/Gun_body/Gun.flip_h=false
					$AnimatedSprite/Gun_body/Gun.flip_v=true
					$AnimatedSprite/Gun_body.position = Vector2(70, 0)
				else:
					$AnimatedSprite.play("default")
		elif motion.y == 0 and is_on_wall():
			if facing=="left":
				$AnimatedSprite.flip_h=true
				$AnimatedSprite.play("default")
			elif facing=="right":
				$AnimatedSprite.flip_h=false
				$AnimatedSprite.play("default")
		elif motion.y != 0  and is_on_wall():
			if motion.y > 51 or motion.y < -51:
				if motion.x < 0:
					$AnimatedSprite.play("wallslide")
					$AnimatedSprite.flip_h=false
				elif motion.x > 0:
					$AnimatedSprite.play("wallslide")
					$AnimatedSprite.flip_h=true
		elif motion.x == 0 and not is_on_wall():
			if Input.is_action_pressed(right):
				pass
			elif Input.is_action_pressed(left):
				pass
			elif is_on_floor():
				$AnimatedSprite.play("default")
		if not Input.is_action_pressed(left) and motion.x <= 0:
			$AnimatedSprite.get_sprite_frames().set_animation_speed("walk", 10)
			if Input.is_action_pressed(right) and is_on_floor():
				$AnimatedSprite.flip_h=true
				$AnimatedSprite.play("slide")
		if not Input.is_action_pressed(right) and motion.x >= 0:
			$AnimatedSprite.get_sprite_frames().set_animation_speed("walk", 10)
			if Input.is_action_pressed(left) and is_on_floor():
				$AnimatedSprite.flip_h=false
				$AnimatedSprite.play("slide")

func fire_gun(x, y):
	# Causes the player to be launched directly away from x and y
	if y > position.y:
		motion.y -= maxi((y - position.y) * 6, 1000) * GUN_STRENGTH
		motion.y -= GRAVITY
	motion.x += maxi((position.x - x), 1000) * GUN_STRENGTH
	create_bullet(current_weapon)
	
		
func maxi(equ, maximum):
	# Takes an equation and returns the number. If the number is over max, return max
	if equ > maximum:
		return maximum
	else:
		return equ
		
func create_bullet(type):
	if type == "normal":
		var bullet = load("res://Bullet.tscn")
		var bullet_instance = bullet.instance()
		get_parent().add_child(bullet_instance)
		bullet_instance.side = "player"
		get_parent().player_bullets.append(bullet_instance)
		bullet_instance.position = position
		bullet_instance.look_at(get_global_mouse_position())
		bullet_instance.rotation_degrees += 180 + rand_range(-5, 5)
	elif type=="rock" and Input.is_action_just_pressed("fire"):
		var bullet = load("res://rock.tscn")
		var bullet_instance = bullet.instance()
		get_parent().add_child(bullet_instance)
		bullet_instance.side = "player"
		get_parent().player_bullets.append(bullet_instance)
	
	
func die():
	# Every possible way to die! What a cheery function!
	if position.y > 10000:
		health = -1
	if $Collision.overlaps_body(current_level.get_node("Danger")) and not hurt:
		health -= 20
		Hurt()
	for bullet in get_parent().enemy_bullets:
		if $Collision.overlaps_area(bullet.get_node("Collision")):
			health -= 15
			
	for enemy in get_parent().enemys:
		if $Collision.overlaps_area(enemy.get_node("Collision")):
			if not hurt:
				health -= 15
				Hurt()
			
	if health < 0:
		health = 100
		position = respawn
		position = Vector2(0,0)
		motion = Vector2(0,1000)
		for enemy in get_parent().enemys:
			enemy.queue_free()
			get_parent().enemys.erase(enemy)
		
		if lives < 1:
			get_parent().level = 4
			get_parent().change_level(Vector2(0, 0))
			lives = 5
		else:
			get_parent().change_level(Vector2(0, 0))
			lives -= 1

	
func next_level(change):
	for door in get_parent().level_instance.doors:
		if $Collision.overlaps_area(door) and get_parent().enemys.size() == 0:
			get_parent().level = door.trans_data["level"]
			get_parent().change_level(door.trans_data["position"])
		
	
		
	
	

func Hurt():
	# Starts immunnity timer and knocks you away from threat
	if $AnimatedSprite.flip_h == false:
		motion.x -= 500
	else:
		motion.x += 500
	hurt = true
	$"damage cooldown".start()
	

	
func _on_damage_cooldown_timeout():
	hurt = false




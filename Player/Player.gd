extends KinematicBody2D

var motion=Vector2(0,0)
const UP=Vector2(0,-1)
var SPEED=500
const GRAVITY=51
const JUMP_SPEED=1200
const JUMP_SUBLIMIT = 80
const WORLD_LIMIT=300000000000
const MAX_BULLETS = 1
const GUN_STRENGTH = 1.3
const MAX_MOTION = Vector2(1000, 1500)
const STOP_SPEED = 100
const MAX_WALL_SLIDE_SPEED = 20
var jump_count=0
var wall_slide_speed=0
var wall_slide_max=2
var is_working = true
var earlyjump = false 
var can_jump = false
var can_wall_jump = false
var godmode = false
var left = "left"
var right = "right"
var jump = "jump"
var facing = "right"
var gun_shots = MAX_BULLETS
var can_fire = true
var reloading = false
var health = 100
var respawn = Vector2()
var strength = 10
var current_level
var hurt = false
var has_wall_jump = true
var max_jump_count = 1
var has_gun = false
var lives = 1
var paused = false
var max_jump = 1 
var wall_jumping = false
var wall=null



func _ready():
	pass
	
func _physics_process(delta):
	# Make sure the player level aligns with the actual level
	current_level = get_parent().level_instance
	
	# These funtions trigger every frame for movment, animation, etc 
	apply_gravity()
	motion.x = clamp(motion.x, -MAX_MOTION.x, MAX_MOTION.x)
	motion.y = clamp(motion.y, -MAX_MOTION.y, MAX_MOTION.y)
	bounce()
	move_and_slide(motion, UP, false, 4, 0.785398, false)
	up_collision()
	side_collision()
	if not paused:
		movement(left,right)
		jumping(jump,left,right)
		jump_breaker(jump)
		early_jump(jump,left,right)
		bounce()
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
		get_parent().get_node("UI").visible = true
		get_parent().get_node("UI/debug menu").visible = true
	else:
		if gun_shots > 1:
			gun_shots = 1
		get_parent().get_node("UI").visible = false
		get_parent().get_node("UI/debug menu").visible = false
	
	if not gun_shots == 3:
		if motion.y > -800:
			gun()
	else:
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
	health = 100
		
	
		
func gun():
	gun_shots = round(gun_shots)
	if Input.is_action_just_pressed("fire") and gun_shots > 0 and can_fire and has_gun:
		get_parent().get_node("Camera2D").shake(60, 0, 5)
		if gun_shots == MAX_BULLETS:
			motion.y = 0
		fire_gun(get_parent().get_node("Target").position.x, get_parent().get_node("Target").position.y)
		gun_shots -= 1
	if gun_shots < 1 and is_on_floor(): 
		reloading = true
		can_fire = false
	if can_fire == false and gun_shots > MAX_BULLETS-1:
		can_fire = true
	if reloading:
		gun_shots += 0.1
		if gun_shots > MAX_BULLETS-0.1:
			reloading = false
	# Cycle through the refills. If touching, refill ammo and delete the refill
	for refill in get_tree().get_nodes_in_group("refills"):
		if $Collision.overlaps_area(refill) and refill.visible:
			can_fire = true
			gun_shots = MAX_BULLETS
			refill.visible = false
	if is_on_floor() or is_on_wall() and gun_shots < MAX_BULLETS:
		gun_shots = MAX_BULLETS
		
	# Reward the player with a purple flash after running out of ammo
	if gun_shots == 0:
		$AnimatedSprite.self_modulate.r8 = 135
		$AnimatedSprite.self_modulate.g8 = 30
		$AnimatedSprite.self_modulate.b8 = 146
	else:
		$AnimatedSprite.self_modulate.r8 = 255
		$AnimatedSprite.self_modulate.g8 = 255
		$AnimatedSprite.self_modulate.b8 = 255

func up_collision():
	if is_on_ceiling():
		motion.y=1
		#if player bumps its head to ceiling, it will start to fall
		
func side_collision():
	#this function makes player stick to wall, also it stops player running animations when it hits a wall
	if is_on_wall() and not is_on_floor():
		if $AnimatedSprite.flip_h:
			motion.x = 0
		elif not $AnimatedSprite.flip_h:
			motion.x = 0
	else:
		if is_on_wall():
			motion.x=0
			
			
			
func apply_gravity():
	if is_on_floor() and motion.y > 0:
		jump_count=max_jump_count
		motion.y=1
	elif is_on_wall() and not is_on_floor() and Input.is_action_pressed("wall hold"):
		if motion.y > 0:
			motion.y = 0
			
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
		motion.x = clamp(motion.x - STOP_SPEED, 0, SPEED)
	elif motion.x<0 and is_on_floor():
		motion.x = clamp(motion.x + STOP_SPEED, -SPEED, 0)
	
	# Make the player slower when falling
	if is_on_floor() or motion.y < -500:
		SPEED = 500
	else:
		if SPEED > 400:
			SPEED -= 20
	
	# keep the player agaisnt the wall for a wall jump
	
		
		
func left():
	if not wall_jumping:
		$AnimatedSprite.flip_h = true
		facing = "left"
	# Dont use speedcap if the player has been launched by somthing
	if motion.x <= -SPEED and motion.x > -SPEED-51:
		motion.x = -SPEED
	else:
		if is_on_wall() and $AnimatedSprite.animation == "wallslide":
			if motion.x == 1:
				yield(get_tree().create_timer(0.1),"timeout")
				motion.x -= 50
		else:
			if not wall_jumping:
				motion.x-=50
				
			
		
func right():
	if not wall_jumping:
		$AnimatedSprite.flip_h = false
		facing = "right"
	# Dont use speedcap if the player has been launched by somthing
	if motion.x >= SPEED and motion.x < SPEED+51:
		motion.x = SPEED
	else:
		if is_on_wall() and $AnimatedSprite.animation == "wallslide":
			if motion.x == -1:
				yield(get_tree().create_timer(0.1),"timeout")
				motion.x += 50
		else:
			if not wall_jumping:
				motion.x+=50
		
	
func jumping(jump,left,right):
	if jump_count > 0:
		if (jump_count == max_jump_count and is_on_floor()) or jump_count < max_jump_count:
			can_jump = true
	if Input.is_action_just_pressed(jump) or earlyjump:
		#earlyjump variable here is makes sure player jumps even if we press slightly early
			if is_on_floor() or can_jump:
				$AnimatedSprite.stop()
				$AnimatedSprite.frame = 0
				$AnimatedSprite.play("jump")
				
				motion.y = -JUMP_SPEED
				jump_count-=1
				
				# Being able to jump gaurentees that the player is on the ground
				gun_shots = MAX_BULLETS

		
			
				
				
				
				
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
				else:
					$AnimatedSprite.play("default")
			elif facing=="right" and is_on_floor():
				if Input.is_action_pressed(right):
					$AnimatedSprite.flip_h=false
					$AnimatedSprite.play("walk")
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
					$AnimatedSprite.flip_h=true
				elif motion.x > 0:
					$AnimatedSprite.play("wallslide")
					$AnimatedSprite.flip_h=false
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
		
		if $AnimatedSprite.flip_h:
			$AnimatedSprite/Gun_body/Gun.flip_h=false
			$AnimatedSprite/Gun_body/Gun.flip_v=false
			$AnimatedSprite/Gun_body.position = Vector2(-70, 0)
		else:
			$AnimatedSprite/Gun_body/Gun.flip_h=false
			$AnimatedSprite/Gun_body/Gun.flip_v=true
			$AnimatedSprite/Gun_body.position = Vector2(70, 0)

func fire_gun(x, y):
	# Causes the player to be launched directly away from x and y
	if not is_on_floor() and motion.y > 0:
		motion.y = -10
	if not is_on_floor():
		if y > position.y:
			motion.y -= clamp((y - position.y) * 6, 0, 1000) * GUN_STRENGTH
			motion.y -= GRAVITY
		motion.x += clamp(position.x - x, -600, 600) * GUN_STRENGTH
	create_bullet()
	
		
func maxi(equ, maximum):
	# Takes an equation and returns the number. If the number is over max, return max
	if equ > maximum:
		return maximum
	else:
		return equ
		
func create_bullet(type="normal"):
	if type == "normal":
		var bullet = load("res://Bullet.tscn")
		var bullet_instance = bullet.instance()
		get_parent().add_child(bullet_instance)
		bullet_instance.side = "player"
		get_parent().player_bullets.append(bullet_instance)
		bullet_instance.position = position
		bullet_instance.look_at(get_parent().get_node("Target").position)
		bullet_instance.rotation_degrees += 180 + rand_range(-5, 5)

	
	
func die():
	# Every possible way to die! What a cheery function!
	if position.y > 4000:
		health = -1
	if $Collision.overlaps_body(current_level.get_node("Danger")) and not hurt:
		health -= 1000
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
		get_parent().change_level(Vector2(0, 0))
		health = 100
		position = respawn
		position = Vector2(0,0)
		motion = Vector2(0,1000)

		if lives < 1:
			get_parent().change_level(Vector2(0, 0))
			lives = 1
	

	
func next_level(change):
	for door in get_tree().get_nodes_in_group("level portals"):
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
	
func bounce():
	for bounce in get_tree().get_nodes_in_group("bounceys"):
		if $Collision.overlaps_area(bounce.get_node("Area2D")):
			motion.y = 0
			motion += bounce.transform.x * SPEED * bounce.power
			bounce.get_node("AnimationPlayer").play("bounce")
			gun_shots = MAX_BULLETS
	
func _on_damage_cooldown_timeout():
	hurt = false

func _on_Thought_animation_finished():
	$Thought.play("default")

func flip_player():
	# Flip the body
	if facing == "right":
		left()
	else:
		right()


func _on_Wall_jump_cooldown_timeout():
	wall_jumping = false



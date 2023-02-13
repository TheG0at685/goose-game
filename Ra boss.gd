extends KinematicBody2D

onready var player = get_tree().root.get_child(0).get_node("Player")
onready var bullet = load("res://bullet.tscn")

var speed = 1
var can_horizontal_attack = false
var can_explode = false
var explodeing = false

var health = 3000

var show_credits = false
var dead = false



# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	$Timer2.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(can_horizontal_attack)
	if health > -1:
		prep_hor()
		if explodeing:
			explosion_attack()
		if can_explode:
			prep_exp()
		shot()
	else:
		if not dead:
			$"death timer".start()
			dead = true
		print($"death timer".time_left)
		if show_credits:
			$CanvasLayer.show()

		
	animation()

func horazontil_attack():
	$ra.animation = "fireball"
	can_horizontal_attack = false
	for i in range(10):
		var bullet_instance = bullet.instance()
		bullet_instance.side = "enemy"
		get_tree().root.get_child(0).add_child(bullet_instance)
		get_tree().root.get_child(0).enemy_bullets.append(bullet_instance)
		bullet_instance.position = Vector2((position.x - 500)+(i*100), position.y)
		bullet_instance.look_at(get_tree().root.get_child(0).get_node("Player").position)
		bullet_instance.rotation_degrees += 180
		
func explosion_attack():
	if scale.x < 3:
		scale.x += 0.01
		scale.y += 0.01
	else:
		explodeing = false
		can_explode = false
		scale = Vector2(1, 1)
		modulate.a8 = 255

func prep_hor():
	if position.distance_to(get_tree().root.get_child(0).get_node("Player").position) < 300:
		can_horizontal_attack = false
		if position.x > player.position.x:
			position.x += 1 * speed
		else:
			position.x -= 1 * speed
		if position.y > player.position.y:
			position.y += 1 * speed
		else:
			position.y -= 1 * speed
	
	elif position.distance_to(get_tree().root.get_child(0).get_node("Player").position) > 400:
		can_horizontal_attack = true
		if position.x > player.position.x:
			position.x -= 1 * speed
		else:
			position.x += 1 * speed
		if position.y > player.position.y:
			position.y -= 1 * speed
		else:
			position.y += 1 * speed
	else:
		can_horizontal_attack = true

func prep_exp():
	if modulate.a8 < 100:
		modulate.a8 += 1
	else:
		explodeing = true
		
func animation():
	if player.position.x > position.x:
		$ra.flip_h = true
	else:
		$ra.flip_h = false
	if not explodeing and get_tree().root.get_child(0).enemy_bullets.size() == 0:
		$ra.animation = "default"
	if explodeing:
		$ra.animation = "explode"
	if health < 0:
		rotation_degrees = 90
		$ra.animation = "dead"
		if position.y < 200:
			position.y += 5
		if self in get_tree().root.get_child(0).enemys:
			get_tree().root.get_child(0).enemys.erase(self)
		
func shot():
	for bullet in get_tree().root.get_child(0).player_bullets:
		if $Collision.overlaps_area(bullet.get_node("Collision")):
			health -= player.strength
	
func _on_Timer_timeout():
	if can_horizontal_attack:
		
		horazontil_attack()
	


func _on_Timer2_timeout():
	can_explode = true
	


func _on_death_timer_timeout():
	show_credits = true

extends KinematicBody2D


onready var player = get_tree().current_scene.get_node("Player")
var speed = 200
var velocity = Vector2()
var gravity = 0
var gravity_muilti = 10
var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemys")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	apply_gravity()
	attack_player()
	damage()
	move_and_slide(velocity, Vector2(0, -1), false, 4, 0.785398, false)
	velocity = Vector2()

func apply_gravity():
	if is_on_floor():
		gravity = 0
	else:
		gravity += gravity_muilti
	velocity.y += gravity

func attack_player():
	if $Area2D.overlaps_body(player):
		# Is the player to the left or right of us
		if position.x > player.position.x:
			# The player is to the left
			velocity.x -= speed
			$AnimatedSprite.flip_h = true
		else:
			# The player is to the right
			velocity.x += speed
			$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("default")
		
func damage():
	for bullet in get_tree().get_nodes_in_group("bullets"):
		if bullet.get_node("Collision").overlaps_body(self):
			health -= 10
			velocity += bullet.velocity*3
			bullet.queue_free()
	for danger in get_tree().get_nodes_in_group("dangers"):
		if $Collision.overlaps_body(danger):
			health = -1
	if health <= 0:
		queue_free()
			

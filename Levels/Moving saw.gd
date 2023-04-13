
extends KinematicBody2D

export var moving = true
export var speed = 3
export var spin_speed = 5
export var position1 = Vector2()
export var position2 = Vector2()
var destination = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	position1 = position
	moving = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving:
		if destination == 2:
			if position.x > position2.x + speed:
				position.x -= speed
			elif position.x < position2.x - speed:
				position.x += speed
			if position.y > position2.y + speed:
				position.y -= speed
			elif position.y < position2.y - speed:
				position.y += speed
			if position.distance_to(position2) < speed*5:
				destination = 1
		elif destination == 1:
			if position.x > position1.x + speed:
				position.x -= speed
			elif position.x < position1.x - speed:
				position.x += speed
			if position.y > position1.y + speed:
				position.y -= speed
			elif position.y < position1.y - speed:
				position.y += speed
			if position.distance_to(position1) < speed*5:
				destination = 2
		rotation_degrees += spin_speed

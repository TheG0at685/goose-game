extends KinematicBody2D


var velocity = Vector2()
onready var topcontrol = get_parent().get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.distance_to(topcontrol.get_node("Player").position) < 300:
		if position.x > topcontrol.get_node("Player").position.x:
			velocity.x -= 100
		else:
			velocity.x += 100
	velocity.y += 2
	if position.y > 100000:
		queue_free()
	move_and_slide(Vector2(velocity.x, velocity.y))
	velocity.x = 0

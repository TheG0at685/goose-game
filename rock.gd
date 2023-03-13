extends RigidBody2D


var velocity = Vector2()
var speed = 500

# determines if it is the player or the enemy bullet
var side


var current_level
# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_parent().get_node("Player").position
	look_at(get_parent().get_node("Target").position)
	position += transform.x * 100
	
	apply_central_impulse(-Vector2(get_parent().get_node("Player").position.x-get_parent().get_node("Target").position.x, get_parent().get_node("Player").position.y-get_parent().get_node("Target").position.y)*3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

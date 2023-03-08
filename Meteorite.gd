extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if position.y > 1000:
		gravity_scale = 0
		linear_velocity = Vector2(0, 0)
		$AnimatedSprite.scale = Vector2(20, 20)
		$AnimatedSprite.play("Explosion")
	else:
		$AnimatedSprite.scale = Vector2(5, 5)
		
	# Remove from game scene after exploding
	if $AnimatedSprite.animation == "Explosion" and $AnimatedSprite.frame == 7:
		queue_free()




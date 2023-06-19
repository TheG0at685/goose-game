extends Area2D


onready var player = get_tree().current_scene.get_node("Player")


# Called when the node enters the scene tree for the first time.
func _ready():
	fire_laser()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ($CollisionShape2D/Particles2D.emitting or $CollisionShape2D/CPUParticles2D.emitting) and overlaps_body(player):
		player.health = -1
	print($CollisionShape2D/Particles2D.emitting)
		

func fire_laser():
	look_at(player.position)
	rotation_degrees += 180
	$AnimationPlayer.play("Shoot")


func _on_AnimationPlayer_animation_finished(anim_name):
	fire_laser()

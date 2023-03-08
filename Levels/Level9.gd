extends KinematicBody2D

onready var doors = [$door9]
onready var boss = load("res://Ra boss.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var ra = boss.instance()
	get_parent().add_child(ra)
	get_parent().enemys.append(ra)
	ra.position = Vector2(750, -250)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

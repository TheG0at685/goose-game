extends KinematicBody2D


onready var doors = [$door5]

var mummie = load("res://mummie.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(1):
		var mummie_instance = mummie.instance()
		add_child(mummie_instance)
		mummie_instance.position = Vector2(i * 500, -400)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

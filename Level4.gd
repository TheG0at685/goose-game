extends KinematicBody2D


onready var doors = [$door4]

var summoned_birds = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not summoned_birds:
		for i in range(3):
			var bird = load("res://Crow.tscn")
			var bird_instance = bird.instance()
			add_child(bird_instance)
			bird_instance.position = Vector2(i*250, rand_range(-300, -1000))
		summoned_birds = true


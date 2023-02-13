extends CanvasLayer

var done_transition = true
var rand_value
var coins = 0

onready var player = get_parent().get_node("Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	var life_sprite = load("res://Life sprite.tscn")
	for i in range(5):
		var life_instance = life_sprite.instance()
		$Lives.add_child(life_instance)
		life_instance.life_id = i+1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	visible = true

	


	


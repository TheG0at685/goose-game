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
	door_open()
	

func door_open():
	for door in get_parent().level_instance.doors:
		# Change the y position based off of closnes to the nearest door
		$MeshInstance2D.position.y = get_distance_to_closesed_door()*5
		if $MeshInstance2D.position.y < 450:
			$MeshInstance2D.position.y = 450
	
func factorial(n):
	var holdvalue = 0
	var boolis = true
	if n == 0 or n == 1:
		holdvalue = 1
	else:
		while n > 0:
			if boolis:
				boolis = false
				holdvalue = n
			else:
				holdvalue = holdvalue * n
			n = n-1
	return holdvalue
	
func get_distance_to_closesed_door():
	var dist = 10000000
	var temp_dist = 0
	for door in get_parent().level_instance.doors:
		temp_dist = player.position.distance_to(door.position)
		if temp_dist < dist:
			dist = temp_dist
	return dist
	
func level_transition(reset=false):
	if reset:
		done_transition = false
		var power_ups = ["speed"]
		rand_value = power_ups[randi() % power_ups.size()]
		if rand_value == "speed":
			player.SPEED *= 1
		
		else:
			done_transition = true
			$Speed.visible = false

extends CanvasLayer


var powers = ["speed+", "strength+", "health+", "extra jump", "critical chance+"]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		if Input.is_action_pressed("power1"):
			print(1)
			get_tree().paused = false
			get_parent().get_node("Player").powerup($power1.text)
			visible = false
	
	


		if Input.is_action_pressed("power2"):
			get_tree().paused = false
			get_parent().get_node("Player").powerup($power2.text)
			visible = false


		if Input.is_action_pressed("power3"):
			get_tree().paused = false
			get_parent().get_node("Player").powerup($power3.text)
			visible = false

func show_power_up():
	randomize()
	visible = true
	get_tree().paused = true
	$power1.text = powers[rand_range(0, len(powers)-1)] + " click 1"
	$power2.text = powers[rand_range(0, len(powers)-1)] + " click 2"
	$power3.text = powers[rand_range(0, len(powers)-1)] + " click 3"



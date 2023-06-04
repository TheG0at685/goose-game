extends CanvasLayer

var done_transition = true
var rand_value
var coins = 0

onready var player = get_parent().get_node("Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	$"Black overlay".hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	visible = true
	if not $"Cutscene player".is_playing():
		$"Cutscene player".hide()
	else:
		$"Cutscene player".show()
		if Input.is_action_just_released("x"):
			$"Cutscene player".stop()
			$"Cutscene player".emit_signal("finished")
		


	



	


extends ParallaxBackground


onready var player = get_parent().get_node("Player")
export var mode = "temple"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	offset.x = player.position.x * -0.01
	offset.y = player.position.y * -0.002
	if mode == "desert":
		$"Desert background".visible = true
		$"Temple background".visible = false
	else:
		$"Desert background".visible = false
		$"Temple background".visible = true
	

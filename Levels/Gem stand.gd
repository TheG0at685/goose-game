extends Area2D


onready var player = get_tree().current_scene.get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Default.visible = true
	$Taken.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if overlaps_body(player):
		$Default.visible = false
		$Taken.visible = true
		get_parent().get_node("Falling object").fall()

extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if position.distance_to(get_parent().get_parent().get_node("Player").position) < 1000000:
		get_parent().get_parent().get_node("UI").area_title("Egypt -->")
	
		

extends Popup


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func display(name, diolauge, profile):
	popup()
	$Name.text = name
	$Diolauge.text = diolauge
	$Sprite.texture = load(profile)





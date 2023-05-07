extends RichTextLabel


var seconds = 0
var minutes = 0
var hours = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = str(hours)+":"+str(minutes)+":"+str(seconds)

func _on_Second_timeout():
	seconds += 1
	if seconds == 60:
		seconds = 0
		minutes += 1
	if minutes == 60:
		minutes = 0
		seconds = 0
		hours += 1

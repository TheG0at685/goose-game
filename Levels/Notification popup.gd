extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("ui_accept") and visible:
		visible = false
		get_tree().paused = false

func popup(text):
	visible = true
	get_tree().paused = true
	$RichTextLabel2.text = text
	

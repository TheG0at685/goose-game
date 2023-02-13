extends Area2D


var current_powerup = 0
var playing_animation = false
var frames_played = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if overlaps_body(get_parent().get_parent().get_node("Player")):
		if current_powerup == 0 and get_parent().get_parent().get_node("UI").coins > 100 and not playing_animation:
			get_parent().get_parent().get_node("Player").SPEED *= 1.25
			current_powerup = 1
			playing_animation = true
		if current_powerup == 1 and get_parent().get_parent().get_node("UI").coins > 300 and not playing_animation:
			get_parent().get_parent().get_node("Player").strength *= 1.5
			current_powerup = 2
			playing_animation = true
			
	if playing_animation:
		if current_powerup == 1:
			get_parent().get_parent().get_node("UI").get_node("Sprite").show()
			frames_played += 1
			if frames_played > 100:
				playing_animation = false
				frames_played = 0
				
		if current_powerup == 2:
			print(1)
			get_parent().get_parent().get_node("UI").get_node("Sprite2").show()
			frames_played += 1
			if frames_played > 100:
				playing_animation = false
			

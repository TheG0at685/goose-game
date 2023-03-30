extends Node2D


var refills = []
var player_bullets = []
var enemy_bullets = []
var enemys = []


var level1
var level_instance
var level = 1
var pause_menu = load("res://Pause menu.tscn")
var menu_instance = pause_menu.instance()

# The closer it is to 0, the faster it will run
var run_speed = 0
var current_song = "Goose theme.mp3"



# Called when the node enters the scene tree for the first time.
func _ready():
	new_level(Vector2(0, 0), level)
	add_child(menu_instance)

	# Draw the pause menu after everything else to put it at the front of the scene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_level(pos):
	# Reset the scrolling background
	$ParallaxBackground2.offset = Vector2(0, 0)
	for enemy in enemys:
		enemy.queue_free()
	enemys.clear()
	remove_child(level_instance)
	menu_instance.queue_free()

	for e in enemys:
		remove_child(e)
	level_instance.queue_free()
	new_level(pos, 99999)
		
	pause_menu = load("res://Pause menu.tscn")
	menu_instance = pause_menu.instance()
	add_child(menu_instance)
		
func new_level(pos, checking):
	$UI/ScreenFade/AnimationPlayer.play("screen fade")
	$Player.position = pos
	$Player.motion.x = 0
	for i in range(checking):
		if level == i+1:
			if level > 1:
				$UI.coins += 10
			var level_format = "res://Levels/Level%d.tscn"
			level1 = load(level_format % [level])
			level_instance = level1.instance()
			add_child(level_instance)
	for bullet in get_tree().get_nodes_in_group("bullets"):
		bullet.queue_free()




func _on_AnimationPlayer_animation_finished(anim_name):
	pass


func _on_Button_pressed():
	level = int($"UI/debug menu/SpinBox".text)
	change_level(Vector2(0, 0))
	
func time_slow():
	if Input.is_action_pressed("time slow"):
		if run_speed > 0.1:
			run_speed += 0.005
	else:
		run_speed = 0

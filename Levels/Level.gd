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
var current_song = null
var shown_gun_tutorial = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	new_level(Vector2(0, 0), level)
	add_child(menu_instance)

	# Draw the pause menu after everything else to put it at the front of the scene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	play()
	if level < 11:
		$ParallaxBackground2.mode = "temple"
	else:
		$ParallaxBackground2.mode = "desert"

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
	#$UI/ScreenFade/AnimationPlayer.play("screen fade")
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
		
func play():
	if not current_song == null:
		if not $Player/AudioStreamPlayer2D.playing:
			$Player/AudioStreamPlayer2D.stream = load(current_song)
			$Player/AudioStreamPlayer2D.play()
		if not $Player/AudioStreamPlayer2D.stream == load(current_song):	
			$Player/AudioStreamPlayer2D.stream = load(current_song)
			$Player/AudioStreamPlayer2D.playing = true 
	else:
		$Player/AudioStreamPlayer2D.stop()

		


func _on_Cutscene_player_finished():
	get_tree().paused = false
	var boss = load("res://Boss.tscn").instance()
	level_instance.add_child(boss)
	boss.position = Vector2(5000, -2800)

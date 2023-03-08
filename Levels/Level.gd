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



# Called when the node enters the scene tree for the first time.
func _ready():
	new_level(Vector2(0, 0), 1)
	add_child(menu_instance)

	# Draw the pause menu after everything else to put it at the front of the scene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	play_music()
	
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
	new_level(pos, 9)
		
	pause_menu = load("res://Pause menu.tscn")
	menu_instance = pause_menu.instance()
	add_child(menu_instance)
		
func new_level(pos, checking):
	$UI/ScreenFade/AnimationPlayer.play("screen fade")
	$Player.position = pos
	for i in range(checking):
		if level == i+1:
			if level > 1:
				$UI.coins += 10
			var level_format = "res://Levels/Level%d.tscn"
			level1 = load(level_format % [level])
			level_instance = level1.instance()
			add_child(level_instance)
	
func play_music():
	if not $AudioStreamPlayer2D.playing:
		if not $Player.godmode or level == 9:
			$AudioStreamPlayer2D.play()
	if $Player.godmode or level == 9:
		$AudioStreamPlayer2D.stop()
		if not $Player/AudioStreamPlayer2D.playing:
			$Player/AudioStreamPlayer2D.play()
	else:
		$Player/AudioStreamPlayer2D.stop()
	$AudioStreamPlayer2D.position = $Player.position


func _on_AnimationPlayer_animation_finished(anim_name):
	pass

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
	new_level(1)
	add_child(menu_instance)

	# Draw the pause menu after everything else to put it at the front of the scene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	play_music()
	
func change_level(position):
	# Reset the scrolling background
	$ParallaxBackground2.offset = Vector2(0, 0)
	for enemy in enemys:
		enemy.queue_free()
	enemys.clear()
	remove_child(level_instance)
	menu_instance.queue_free()

	for e in enemys:
		remove_child(e)
	if level == 1:
		$Player.position = position
		new_level(1)
	if level == 2:
		$Player.position = position
		new_level(2)
	if level == 3:
		$Player.position = position
		new_level(3)
	if level == 4:
		$Player.position = position
		new_level(4)
	if level == 5:
		$Player.position = position
		new_level(5)
	if level == 6:
		$Player.position = position
		new_level(6)
	if level == 7:
		$Player.position = position
		new_level(7)
	if level == 8:
		$Player.position = position
		new_level(8)
	if level == 9:
		$Player.position = position
		new_level(9)
		
	pause_menu = load("res://Pause menu.tscn")
	menu_instance = pause_menu.instance()
	add_child(menu_instance)
		
func new_level(level):
	if level > 2:
		$UI.coins += 10
	var level_format = "res://Level%d.tscn"
	level1 = load(level_format % [level])
	print(level1)
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

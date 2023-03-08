extends TileMap

var mummie = load("res://crow.tscn")

var spawned_mummies = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not spawned_mummies and $Area2D.overlaps_body(get_tree().current_scene.get_node("Player")):
		for tile in get_used_cells():
			var mummie_instance = mummie.instance()
			get_tree().current_scene.add_child(mummie_instance)
			mummie_instance.position = tile + position + get_parent().position + get_parent().get_parent().position
			spawned_mummies = true
		


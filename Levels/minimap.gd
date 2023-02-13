extends Sprite

func _process(delta):
	get_parent().get_parent().get_viewport().set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	# Wait until the frame has finished before getting the texture.
	yield(VisualServer, "frame_post_draw")

	# Retrieve the captured image.
	var img = get_parent().get_parent().get_viewport().get_texture().get_data()

	# Flip it on the y-axis (because it's flipped).
	img.flip_y()

	# Create a texture for it.
	var tex = ImageTexture.new()
	tex.create_from_image(img)

	# Set the texture to the captured image node.
	set_texture(tex)

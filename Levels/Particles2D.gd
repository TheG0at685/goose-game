extends Particles2D

var emission_shape: EmissionShape

func _ready():
	# Set initial properties of the fire effect
	process_material = ParticlesMaterial.new()
	emission_shape = EmissionShape.new()
	
	# Configure the emission shape
	emission_shape.shape = EmissionShape.SHAPE_POINT
	emission_shape.emit_count = 20
	emission_shape.emission_sphere_radius = 5
	
	# Configure the particles material
	process_material.emission_colors = PoolColorArray([Color(1, 1, 1, 1), Color(1, 0.6, 0.2, 0)])
	process_material.color_ramp = Gradient.new()
	process_material.color_ramp.add_point(0, Color(1, 1, 1, 1))
	process_material.color_ramp.add_point(0.5, Color(1, 0.6, 0.2, 0.5))
	process_material.color_ramp.add_point(1, Color(1, 0.1, 0.1, 0))
	process_material.direction = -0.3
	process_material.speed_scale = 0.8
	process_material.emission_box_extents = Vector3(0.2, 0.2, 0.2)
	
	# Assign the emission shape and material to the Particles2D node
	set_emission_shape(emission_shape)
	set_process_material(process_material)

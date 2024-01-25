extends CollisionShape3D

var last_mouse_position = Vector2()

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		last_mouse_position = get_viewport().get_mouse_position()
		check_collision()

func check_collision():
	var collision_point = get_viewport().get_mouse_position()
	var collision_result = $MeshInstance.world_ray_intersects_position(last_mouse_position)

	if collision_result:
		var mesh_instance = collision_result.collider
		var mesh = mesh_instance.get_mesh()
		var mesh_transform = mesh_instance.global_transform

		# Get the collision point in local coordinates of the MeshInstance
		var local_collision_point = mesh_transform.affine_inverse().xform(collision_result.position)

		# Get the size of the texture assigned to the MeshInstance
		var texture_size = mesh.get_texture_size("albedo")

		# Calculate UV coordinates
		var uv_coordinates = Vector2(local_collision_point.x / texture_size.x, local_collision_point.y / texture_size.y)

		print("UV Coordinates:", uv_coordinates)
	else:
		print("No collision detected.")

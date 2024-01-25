extends CharacterBody3D

var is_dragging = false
var initial_mouse_pos

@export var mouse_speed = 1
@export var up_speed = 8
@export var down_speed = 8
 
@export var color: Color = Color.RED
@export var brush_size: int = 10
@export var texture: Texture2D
 
#@onready var draw_viewport: Viewport = $"/root/Node3D/DrawViewport"
 
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
 
func _physics_process(delta):
	#velocity.y -= gravity * delta
	velocity = Vector3.ZERO
	handle_mouse_movement()
	handle_up_down_movement()
	
	move_and_slide()
	
	handle_collisions()
	
				
func handle_collisions():
	if get_slide_collision_count() > 0:
		for i in range(0, get_slide_collision_count()):
			var col = get_slide_collision(i)
			var body := col.get_collider()
			
			var path_to = "/" + body.get_parent().get_path().get_concatenated_names()
			var viewport = get_node(path_to + "/DrawViewport")
			
			path_to = "/" + body.get_parent().get_path().get_concatenated_names()
			var uv_pos = get_node(path_to).uv_pos
			
			var top_obj = viewport.get_parent().get_parent()
			
			var scale = top_obj.scale
			
			var pos: Vector3 = top_obj.to_local(col.get_position())
			pos = Vector3(pos.x * scale.x, pos.y * scale.y, pos.z * scale.z)

			var local_normal: Vector3 = col.get_normal() * top_obj.global_transform.basis
			
			var uv = uv_pos.get_uv_coords(pos, local_normal, true)
			if uv and viewport:
				print(uv)
				viewport.paint(uv, color, brush_size, texture)
		
func handle_mouse_movement():
	if Input.is_action_pressed("left_click"):
		if not is_dragging:
			is_dragging = true
			initial_mouse_pos = get_viewport().get_mouse_position()  # Get the initial mouse position in global coordinates
		else:
			var current_mouse_pos = get_viewport().get_mouse_position()
			var delta_pos = current_mouse_pos - initial_mouse_pos
			initial_mouse_pos = current_mouse_pos
			
			delta_pos *= mouse_speed

			# Move the object based on the delta of the mouse transform delta
			var apply_pos = Vector3(delta_pos.x, 0, delta_pos.y)
			velocity += apply_pos
			#var new_position = position + apply_pos
			#position = new_position
	else:
		is_dragging = false
		
func handle_up_down_movement():
	if Input.is_action_pressed("move_down"):
		velocity += Vector3(0, -down_speed, 0)
		#var new_position = position + Vector3(0, -down_speed, 0)
		#position = new_position
	
	if Input.is_action_pressed("move_up"):
		velocity += Vector3(0, up_speed, 0)
		#var new_position = position + Vector3(0, up_speed, 0)
		#position = new_position

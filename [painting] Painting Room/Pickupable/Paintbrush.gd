extends CharacterBody3D

var is_dragging = false
var initial_mouse_pos

@export var mouse_speed = 1
@export var up_speed = 8
@export var down_speed = 8
 
@export var color: Color = Color.RED
@export var texture: Texture2D

@export var is_collided: bool = false
 
@onready var globals: Node = get_node("/root/PaintingRoom/Globals")

func _physics_process(delta):
	position = Vector3.ZERO
	move_and_slide()
	handle_collisions()
	
				
func handle_collisions():
	if get_slide_collision_count() > 0:
		for i in range(0, get_slide_collision_count()):
			var col = get_slide_collision(i)
			var body := col.get_collider()
			
			if !get_collision_layer_value(3):
				continue
			
			var path_to = "/" + body.get_parent().get_path().get_concatenated_names()
			var viewport = get_node(path_to + "/DrawViewport")
			
			if !viewport:
				continue
				
			globals.is_collided = true
			
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
				viewport.paint(uv, color, texture)
	else:
		globals.is_collided = false

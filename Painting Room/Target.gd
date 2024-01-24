extends Node3D

var is_dragging = false
var initial_mouse_pos

var mult = 0.01

var up_speed = 0.01
var down_speed = 0.01

func _process(delta):
	handle_mouse_movement()
	handle_up_down_movement()
	
func handle_mouse_movement():
	if Input.is_action_pressed("left_click"):
		if not is_dragging:
			is_dragging = true
			initial_mouse_pos = get_viewport().get_mouse_position()  # Get the initial mouse position in global coordinates
		else:
			var current_mouse_pos = get_viewport().get_mouse_position()
			var delta_pos = current_mouse_pos - initial_mouse_pos
			initial_mouse_pos = current_mouse_pos
			
			delta_pos *= mult

			# Move the object based on the delta of the mouse transform delta
			var apply_pos = Vector3(-delta_pos.y, 0, delta_pos.x)
			var new_position = position + apply_pos
			position = new_position
	else:
		is_dragging = false
		
func handle_up_down_movement():
	if Input.is_action_pressed("move_down"):
		var new_position = position + Vector3(0, -down_speed, 0)
		position = new_position
	
	if Input.is_action_pressed("move_up"):
		var new_position = position + Vector3(0, up_speed, 0)
		position = new_position

extends RigidBody3D
@export var controls: Resource = null;
var rotation_speed := 0.5
var mouse_sensitivity := 0.001
var delay = 2.0
var timer = 0.0
var twist_pivot = null
var pitch_pivot = null

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	twist_pivot = $TwistPivot
	pitch_pivot = $TwistPivot/PitchPivot
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_pressed(controls.move_left):
		twist_pivot.rotate_y(rotation_speed * delta)
	if Input.is_action_pressed(controls.move_right):
		twist_pivot.rotate_y(-rotation_speed * delta)
	if Input.is_action_pressed(controls.move_forward):
		pitch_pivot.rotate_x(rotation_speed * delta)
	if Input.is_action_pressed(controls.move_back):
		pitch_pivot.rotate_x(-rotation_speed * delta)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, 
		deg_to_rad(-20), 
		deg_to_rad(20)
	)
	twist_pivot.rotation.y = clamp(twist_pivot.rotation.y, 
		deg_to_rad(-40), 
		deg_to_rad(40)
	)
	#
	#timer += delta
	#if timer > delay:
		#print("twist pivot for" + str(controls.player_index) + ": " + str(twist_pivot.rotation))
		#print("pitch pivot for" + str(controls.player_index) + ": " + str(pitch_pivot.rotation))
		#timer = 0
	
	

extends CharacterBody3D


const SPEED = 5.0
const DISTANCE_TO_CLAMP = 1

var _last_anim: String
var _last_collided: RigidBody3D
var _held_object: RigidBody3D

var original_z: float
var expected_z: float

@onready var globals = get_node("/root/PaintingRoom/Globals")

@onready var hand_open = $hand_open
@onready var hand_close = $hand_close
@onready var hand_rotate = $hand_rotate
@onready var brush_grabbed = $brush_grabbed


func _ready():
	play_anim("hand_open")
	original_z = global_position.z
	expected_z = original_z


func _physics_process(delta):
	handle_movement_input(delta)
	handle_other_input(delta)

	var collision = move_and_collide(velocity * delta)
	handle_collision(collision)


func handle_movement_input(delta):
	var direction = get_movement_direction()
	

	var z_moving := false
	
	if Input.is_action_pressed("move_up_p1") and !globals.is_collided:
		z_moving = true
		velocity.z = -1 * SPEED
		
	if Input.is_action_pressed("move_down_p1") and global_position.z < 1.9:
		z_moving = true
		velocity.z = 1 * SPEED
	
	if !z_moving:
		velocity.z = move_toward(velocity.z, 0, SPEED)
	

	if Input.is_action_pressed("switch_to_hand_rotation"):
		rotate_hand(direction)
	else:
		move_hand(direction)

	# Override Z position with what we expect, since things can push the arm off the expected Z
	global_position.z = expected_z



func get_movement_direction():
	var input_dir = Input.get_vector("move_hand_left", "move_hand_right", "move_hand_down", "move_hand_up")
	if input_dir == Vector2.ZERO:
		input_dir = Input.get_last_mouse_velocity()
		input_dir.y *= -1

	return Vector3(input_dir.x, input_dir.y, 0).normalized()

var rotating: bool = false

func rotate_hand(direction):
	if direction:
		rotating = true
		var new_rotation = rotation.x + direction.y * 0.1
		if new_rotation >= 0 and new_rotation < 1.5:
			rotation = Vector3(new_rotation, new_rotation * .8, 0)
			expected_z = original_z - new_rotation * 0.49
	else:
		rotating = false
		
	if rotating:
		if !hand_rotate.playing:
			hand_rotate.play()
	else:
		hand_rotate.stop()

	kill_movement()


func move_hand(direction):
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		kill_movement()


func kill_movement():
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)


func handle_other_input(delta):
	if Input.is_action_just_pressed("close_hand"):
		hand_close.play()
	if Input.is_action_just_released("close_hand"):
		hand_open.play()
		
	if Input.is_action_pressed("close_hand"):
		play_anim("default") # was hand_closed
		if _last_collided and _last_collided.global_position.distance_to(self.global_position) < DISTANCE_TO_CLAMP:
			pick_up(_last_collided)
	else:
		play_anim("hand_open")
		drop_held()


func pick_up(object: RigidBody3D):
	if _held_object: return
	if not object or not object.has_method("pick_up"): return

	print("Grabbed a " + object.name)
	brush_grabbed.play()
	object.pick_up(self)
	_held_object = object


func drop_held():
	if not _held_object: return

	print("Dropped a " + _held_object.name)
	_held_object.let_go()
	_held_object = null


func play_anim(anim_name):
	if _last_anim != anim_name:
		$JankRobotArm_RIG/AnimationPlayer.play(anim_name)
		_last_anim = anim_name


func handle_collision(collision):
	if not collision: return

	var collider = collision.get_collider()

	if collider is RigidBody3D and collider != _held_object:
		# Knocks shit off the table
		collider.apply_central_force(-collision.get_normal() * 100)
		_last_collided = collider

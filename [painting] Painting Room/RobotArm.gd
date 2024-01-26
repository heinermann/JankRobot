extends CharacterBody3D


const SPEED = 5.0
const DISTANCE_TO_CLAMP = 1

var _last_anim: String
var _last_collided: RigidBody3D
var _held_object: RigidBody3D


func _ready():
	play_anim("hand_open")


func _physics_process(delta):
	handle_movement_input(delta)
	handle_other_input(delta)

	var collision = move_and_collide(velocity * delta)
	handle_collision(collision)

func handle_movement_input(delta):
	var input_dir = Input.get_vector("move_hand_left", "move_hand_right", "move_hand_down", "move_hand_up")

	if input_dir == Vector2.ZERO:
		# TODO For this to work better we need to lock the mouse cursor to the game and hide it
		# But that has its own problems...
		input_dir = Input.get_last_mouse_velocity()
		input_dir.y *= -1

	var direction = (transform.basis * Vector3(input_dir.x, input_dir.y, 0)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)


func handle_other_input(delta):
	if Input.is_action_pressed("close_hand"):
		play_anim("hand_closed")
		if _last_collided and _last_collided.global_position.distance_to(self.global_position) < DISTANCE_TO_CLAMP:
			pick_up(_last_collided)
	else:
		play_anim("hand_open")
		drop_held()


func pick_up(object):
	if _held_object: return

	print("Grabbed a " + object.name)
	_held_object = object
	#TODO disable its physics and strap it to the hand


func drop_held():
	if not _held_object: return

	print("Dropped a " + _held_object.name)
	_held_object = null
	#TODO reenable physics and unstrap it from hand


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

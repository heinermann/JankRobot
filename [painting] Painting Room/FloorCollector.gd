extends Area3D

@onready var root = get_node("/root/PaintingRoom")

func _on_body_entered(body: Node3D):
	if not body is RigidBody3D: return

	body.global_position = Vector3(0, 3, 1.5)
	body.linear_velocity = Vector3.ZERO
	body.angular_velocity = Vector3.ZERO
	
	root.decrease_mood(root.item_dropped_mood_decrease_amount)

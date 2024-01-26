extends Area3D


func _on_body_entered(body: Node3D):
	if not body is RigidBody3D: return

	body.global_position = Vector3(0, 3, 1.5)
	body.linear_velocity = Vector3.ZERO
	body.angular_velocity = Vector3.ZERO

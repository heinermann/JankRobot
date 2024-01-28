extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Scientist/AnimationPlayer.play("idle")
	$Level/Fans/RoomFan/AnimationPlayer.play("Fan")
	$Level/Fans/RoomFan2/AnimationPlayer.play("Fan")
	$Level/Fans/RoomFan3/AnimationPlayer.play("Fan")
	$Level/Fans/RoomFan4/AnimationPlayer.play("Fan")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

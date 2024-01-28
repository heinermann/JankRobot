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

	var exists = get_node_or_null("/root/PaintingRoom/ResultsMenu")
	if Input.is_action_just_pressed("ui_page_down") and !exists:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		var results_menu = load("res://UI/Menus/ResultsMenu/results_menu.tscn")
		var instance = results_menu.instantiate()
		instance.score = $canvas.get_score()
		add_child(instance)

	pass

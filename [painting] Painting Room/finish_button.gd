extends StaticBody3D

@onready var anim = $AnimationPlayer
@onready var button_anim = get_node("Button/AnimationPlayer")

@export var hold_time: float = 3.0

var current_time: float
var pressed: bool = false


func _process(delta):
	if pressed:
		current_time += delta
		button_anim.play("blink")
	else:
		current_time = 0
		button_anim.stop()
		
	if current_time > hold_time:
		get_node("/root/PaintingRoom").finish_game(true)


func _on_area_3d_body_entered(body):
	if body.name != "ButtonCol":
		pressed = true
		anim.play("press_down")


func _on_area_3d_body_exited(body):
	if body.name != "ButtonCol":
		pressed = false
		anim.play("release")

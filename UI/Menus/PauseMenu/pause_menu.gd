extends Control
var paused = false
@onready var focus_button := $MarginContainer/Panel/MarginContainer/VBoxContainer/Resume
# Called when the node enters the scene tree for the first time.
func _ready():
	focus_button.grab_focus()
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		toggle_pause_menu()

func toggle_pause_menu():
	if paused:
		hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		Engine.time_scale = 1
	else:
		show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Engine.time_scale = 0
	paused = !paused

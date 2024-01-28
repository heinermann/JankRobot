extends Control
var delay = 0.05
var paused = false
var painting_room
@onready var focus_button := $MarginContainer/Panel/MarginContainer/VBoxContainer/Resume
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	painting_room = get_tree().get_root()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		toggle_pause_menu()

func toggle_pause_menu():
	focus_button.grab_focus()
	if paused:
		hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		Engine.time_scale = 1
	else:
		show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Engine.time_scale = 0
	paused = !paused
	


func _on_return_to_main_menu_pressed():
	toggle_pause_menu()
	get_tree().change_scene_to_file("res://UI/Menus/menu.tscn")

func _on_quit_pressed():
	get_tree().quit()


func _on_restart_pressed():
	toggle_pause_menu()
	get_tree().reload_current_scene()


func _on_resume_pressed():
	toggle_pause_menu()


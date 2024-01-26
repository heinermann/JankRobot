extends Control

@export var first_button: Button = null
@export var last_button: Button = null
@export var button_group: ButtonGroup = null
var delay = 0.05
var button_released = null
# Called when the node enters the scene tree for the first time.
func _ready():
	$StartGame.grab_focus()
	for i in get_children():
		if i is Button:
			i.connect("pressed", on_button_pressed)
			if i == first_button:
				i.connect("gui_input", wrap_to_last)
			if i == last_button:
				i.connect("gui_input", wrap_to_first)
				

func on_button_pressed():
	await get_tree().create_timer(delay * 2).timeout
	var pressed_button = button_group.get_pressed_button()
	pressed_button.set_pressed_no_signal(false)

	
func wrap_to_last(event):
	#await get_tree().create_timer(delay).timeout
	if not first_button: 
		push_warning("first button not assigned")
		return
	if event.is_action_pressed("ui_up"):
		await get_tree().create_timer(delay).timeout
		last_button.grab_focus()
	
func wrap_to_first(event):
	#await get_tree().create_timer(delay).timeout
	if not last_button: 
		push_warning("last button not assigned")
		return
	if event.is_action_pressed("ui_down"):
		await get_tree().create_timer(delay).timeout
		first_button.grab_focus()
		

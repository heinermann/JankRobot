extends Control

@export var button_group: ButtonGroup = null
var delay = 0.05
var button_released = null
# Called when the node enters the scene tree for the first time.
func _ready(): 
	for i in get_children():
		if i is Button:
			if i.name == "Restart" or i.name == "ReturnToMainMenu": continue
			i.connect("pressed", on_button_pressed)
				

func on_button_pressed():
	await get_tree().create_timer(delay * 2).timeout
	var pressed_button = button_group.get_pressed_button()
	pressed_button.set_pressed_no_signal(false)
		

extends Control
signal show_main_menu
var mouse_icon = preload("res://addons/controller_icons/assets/mouse/simple.png")
@export var button_group: ButtonGroup = null


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in button_group.get_buttons():
		var button = i as Button
		button.disabled = true
	_on_input_type_changed(ControllerIcons._last_input_type)
	ControllerIcons.input_type_changed.connect(_on_input_type_changed)
	
func _on_input_type_changed(input_type):
	match input_type:
		ControllerIcons.InputType.CONTROLLER:
			get_tree().call_group("ControllerHidden", "hide")
		ControllerIcons.InputType.KEYBOARD_MOUSE:
			get_tree().call_group("ControllerHidden", "show")
			%MoveHand.icon = mouse_icon

func _back_to_game():
	emit_signal("show_main_menu")

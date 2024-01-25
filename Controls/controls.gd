extends Control

var mouse_icon = preload("res://addons/controller_icons/assets/mouse/simple.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_input_type_changed(ControllerIcons._last_input_type)
	ControllerIcons.input_type_changed.connect(_on_input_type_changed)

func _on_input_type_changed(input_type):
	match input_type:
		ControllerIcons.InputType.CONTROLLER:
			get_tree().call_group("ControllerHidden", "hide")
		ControllerIcons.InputType.KEYBOARD_MOUSE:
			get_tree().call_group("ControllerHidden", "show")
			%MoveHand.icon = mouse_icon

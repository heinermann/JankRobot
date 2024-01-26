extends Control

@onready var main_menu := $MainMenu
@onready var controls_menu := $ControlsMenu

func _ready():
	main_menu.visible = true
	controls_menu.visible = false
	main_menu.connect("show_controls_menu", _on_show_controls_menu)
	controls_menu.connect("show_main_menu", _on_show_main_menu)

func _on_show_controls_menu():
	main_menu.visible = false
	controls_menu.visible = true
	controls_menu.get_node("MarginContainer2/Cancel").grab_focus()
func _on_show_main_menu():
	main_menu.visible = true
	controls_menu.visible = false
	main_menu.get_node("MenuContainer2/HBoxContainer/Controls").grab_focus()

extends Control

var controls = preload("res://Controls/controls.tscn").instantiate()

func _ready():
	$MenuContainer/MenuVBoxContainer/StartGame.grab_focus()

func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://[painting] Painting Room/painting room.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_controls_pressed():
	$MenuContainer.hide()
	$MenuContainer2.hide()
	get_tree().root.add_child(controls)

func _on_options_pressed():
	print("Options button pressed");
	#toggle options menu

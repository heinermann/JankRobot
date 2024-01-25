extends Control

var controls = preload("res://Controls/controls.tscn").instantiate()

func _ready():
	%StartGame.grab_focus()

func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://Painting Room/painting room.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_controls_pressed():
	%MenuContainer.hide()
	get_tree().root.add_child(controls)

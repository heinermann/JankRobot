extends Control

signal show_controls_menu

func _ready():
	%StartGame.grab_focus()

func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://[painting] Painting Room/painting room2.tscn")
	
func _on_quit_pressed():
	get_tree().quit()
	
func _on_controls_pressed():
	#print("Controls button pressed");
	emit_signal("show_controls_menu")
		
func _on_options_pressed():
	print("Options button pressed");
	#toggle options menu
	
func _on_controls_menu_show_main_menu():
	pass # Replace with function body.

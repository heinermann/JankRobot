extends Control

var score

# Called when the node enters the scene tree for the first time.
func _ready():
	var count = score[0]
	var body_string = "Pixels painted correctly: %d\nPixels drawn outside the lines: %d\n\nScore: %f"
	get_node("%Body").set_text(body_string % [count[0], count[1], score[1]])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_controls_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://UI/Menus/MainMenu/main_menu.tscn")

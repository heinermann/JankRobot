extends Control

var score

var img: Image

# Called when the node enters the scene tree for the first time.
func _ready():
	var count = score[0]
	var body_string = "Pixels painted correctly: %d\nPixels drawn outside the lines: %d\n\nScore: %f"
	img = score[2]
	get_node("%Body").set_text(body_string % [count[0], count[1], score[1]])
	$Sprite2D.set_texture(ImageTexture.create_from_image(img))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_controls_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://UI/Menus/MainMenu/main_menu.tscn")


func try_to_create_dir(directory, path):
	if not directory.dir_exists(path):
		var error_code = directory.make_dir(path)
		if error_code != OK:
			print("Something went wrong")

func _on_save_pressed():
	var dir = DirAccess.open("user://")
	dir.make_dir("paintings")
	img.save_png("user://paintings/%s.png" % Time.get_datetime_string_from_system())
	pass # Replace with function body.

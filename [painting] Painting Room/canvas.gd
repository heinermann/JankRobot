extends Node3D

@export var paintbucket: Resource
@export var paintbucket_pos: Node3D
@export var distance_between_paints: Vector3

@export var canvas_texture: Texture2D
@export var canvas_top_left: Vector2
@export var canvas_bottom_right: Vector2

@export var choose_random: bool = true
@export var choose_file: String = ""

@export var painting_texture: Texture2D
@export var painting_origin: Vector2
@export var painting_position: Vector2
@export var painting_scale: Vector2
@export var flip_y: bool = false

@export var scoring_colors: Array[Color]
@export var empty_colors: Array[Color]

var score_image: Image

func get_region(img: Image) -> Image:
	return img.get_region(Rect2(canvas_top_left, canvas_bottom_right - canvas_top_left))

func are_colors_equal_with_error(color1: Color, color2: Color, error_margin: float) -> bool:
	return abs(color1.r - color2.r) <= error_margin && abs(color1.g - color2.g) <= error_margin && abs(color1.b - color2.b) <= error_margin && abs(color1.a - color2.a) <= error_margin

func create_texture_with_overlay(input_texture: Texture2D, overlay_texture: Texture2D, painting_origin: Vector2, painting_position: Vector2, painting_scale: Vector2) -> ImageTexture:
	# Convert the input texture to an Image
	var input_image: Image = input_texture.get_image()
	input_image.decompress()
	
	# Convert the overlay texture to an Image
	var overlay_image: Image = overlay_texture.get_image()
	overlay_image.decompress()
	overlay_image.convert(Image.FORMAT_RGBA8)
	var size = overlay_image.get_size()
	overlay_image.resize(size.x * painting_scale.x, size.y * painting_scale.y, 0)
	overlay_image.rotate_180()
	overlay_image.flip_x()
	
	# Calculate the position to center the overlay on the input image
	
	painting_origin.y -= size.y * painting_scale.y
	
	if flip_y:
		painting_position.y *= -1
	
	# Draw the overlay image on top of the input image at the specified position
	input_image.blit_rect(overlay_image, Rect2(Vector2.ZERO, overlay_image.get_size()), painting_origin + painting_position)
	
	#input_image.get_region(Rect2(canvas_top_left, canvas_bottom_right - canvas_top_left)).save_png('res://yes.png')
	score_image = get_region(input_image)
	
	# Create a new ImageTexture from the modified Image
	var result_texture: Texture2D = ImageTexture.create_from_image(input_image)
	
	return result_texture

func count_pixels(canvas_image: Image, painted_image:Image):
	var total_pixels = canvas_image.get_height() * canvas_image.get_width()
	
	var correct_pixels = 0
	var outside_pixels = 0
	var total_correct = 0
	
	for y in range(canvas_image.get_height()):
		for x in range(canvas_image.get_width()):
			var canvas_pixel = canvas_image.get_pixel(x, y)
			var painted_pixel = painted_image.get_pixel(x, y)
			
			var painted: bool = false
			if !are_colors_equal_with_error(painted_pixel, Color(0, 0, 0, 0), 0.05):
				painted = true
				if are_colors_equal_with_error(painted_pixel, canvas_pixel, 0.05):
					correct_pixels += 1
				
			for score in scoring_colors:
				if are_colors_equal_with_error(score, canvas_pixel, 0.05):
					total_correct += 1
			
			for empty in empty_colors:
				if are_colors_equal_with_error(empty, canvas_pixel, 0.05):
					if painted:
						outside_pixels += 1
				
	return [correct_pixels, outside_pixels, total_correct]

func calculate_score(max_score, correct_pixels, outside_pixels, total_correct, outside_objects_painted):
	var score_cap = correct_pixels as float / (total_correct + (outside_pixels / 4)) * max_score

	var outside_penalty_total = 0

	for obj in outside_objects_painted:
		outside_penalty_total += (obj.painted_pixels / obj.total_pixels) * obj.penalty_multiplier

	var score = (correct_pixels as float / (total_correct)) * max_score - outside_penalty_total

	return min(score, score_cap)

func get_score():
	var viewport = get_node('Canvas/DrawViewport')
	var painted_image = get_region(viewport.get_texture().get_image())
	var count = count_pixels(score_image, painted_image)
	return [count, calculate_score(100, count[0], count[1], count[2], []), painted_image]

func read_painting_file(path):
	var config = FileAccess.open("./Paintings/" + path.replace(".png", ".json"), FileAccess.READ)
	var config_parse = JSON.parse_string(config.get_as_text())
	
	painting_position = Vector2(config_parse["pos_x"], config_parse["pos_y"])
	painting_scale = Vector2(config_parse["scale_x"], config_parse["scale_y"])
	
	var new_scoring_colors: Array[Color] = []
	for hex in config_parse["scoring"]:
		new_scoring_colors.push_back(Color(hex))
	scoring_colors = new_scoring_colors
	
	var new_empty_colors: Array[Color] = []
	for hex in config_parse["empty"]:
		new_empty_colors.push_back(Color(hex))
	empty_colors = new_empty_colors
	
func choose_painting():
	var dir = DirAccess.open("./Paintings")
	
	var files = []
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir() and file_name.ends_with(".png"):
				files.push_back(file_name)
			file_name = dir.get_next()
	
	var chosen: int = randi_range(0, files.size() - 1)
	
	read_painting_file(files[chosen])
	
	painting_texture = ImageTexture.create_from_image(Image.load_from_file("./Paintings/" + files[chosen]))

func make_paintbuckets():
	var root = get_node("/root/PaintingRoom")
	var start_pos = paintbucket_pos.position
	
	var paint = load(paintbucket.resource_path)
	
	var cur = 0
	for col in scoring_colors:
		var pos = start_pos + cur * distance_between_paints
		var _paint = paint.instantiate()
		_paint.position = pos
		_paint.color = col
		root.add_child.call_deferred(_paint)
		cur += 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var material = ($Canvas.mesh.surface_get_material(0) as ShaderMaterial)
	
	if choose_random:
		choose_painting()
		make_paintbuckets()
	else:
		if choose_file != "":
			read_painting_file(choose_file)
			make_paintbuckets()
	
	material.set_shader_parameter("MainColor", create_texture_with_overlay(canvas_texture, painting_texture, painting_origin, painting_position, painting_scale))

func _process(delta):
	pass

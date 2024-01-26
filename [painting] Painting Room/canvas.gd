extends Node3D

@export var canvas_texture: Texture2D
@export var painting_texture: Texture2D
@export var painting_origin: Vector2
@export var painting_position: Vector2
@export var painting_scale: Vector2
@export var flip_y: bool = false

func create_texture_with_overlay(input_texture: Texture2D, overlay_texture: Texture2D, painting_origin: Vector2, painting_position: Vector2, painting_scale: Vector2) -> ImageTexture:
	# Convert the input texture to an Image
	var input_image: Image = input_texture.get_image()
	input_image.decompress()
	
	# Convert the overlay texture to an Image
	var overlay_image: Image = overlay_texture.get_image()
	overlay_image.decompress()
	var size = overlay_image.get_size()
	overlay_image.resize(size.x * painting_scale.x, size.y * painting_scale.y, 0)
	overlay_image.rotate_180()
	
	# Calculate the position to center the overlay on the input image
	
	if flip_y:
		painting_position.y *= -1
	
	# Draw the overlay image on top of the input image at the specified position
	input_image.blit_rect(overlay_image, Rect2(Vector2.ZERO, overlay_image.get_size()), painting_origin + painting_position)
	
	get_node("%Sprite3D").set_texture(ImageTexture.create_from_image(input_image))
	
	# Create a new ImageTexture from the modified Image
	var result_texture: Texture2D = ImageTexture.create_from_image(input_image)
	
	return result_texture

# Called when the node enters the scene tree for the first time.
func _ready():
	var material = ($Canvas.mesh.surface_get_material(0) as ShaderMaterial)
	
	material.set_shader_parameter("MainColor", create_texture_with_overlay(canvas_texture, painting_texture, painting_origin, painting_position, painting_scale))

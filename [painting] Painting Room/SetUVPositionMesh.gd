extends MeshInstance3D

@export var flip_normals: bool = false
@onready var uv_pos := UVPosition.new()

func _ready():
	uv_pos.set_mesh(self, flip_normals)
	
	var material = (mesh.surface_get_material(0) as ShaderMaterial)
	var viewport = get_node('DrawViewport')
	
	var texture = viewport.get_texture()
	
	material.set_shader_parameter("Paint", texture)
	

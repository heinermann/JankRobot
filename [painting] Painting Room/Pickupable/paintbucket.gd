extends RigidBody3D

@export var color: Color = Color()

# Called when the node enters the scene tree for the first time.
func _ready():
	$PaintOverlay.mesh = $PaintOverlay.mesh.duplicate()
	$PaintOverlay.mesh.material = $PaintOverlay.mesh.material.duplicate()
	
	var material = $PaintOverlay.mesh.surface_get_material(0)
	material.albedo_color = color
	$PaintOverlay.mesh.surface_set_material(0, material)


func _on_area_3d_body_entered(body):
	if body.has_method("set_brush_color"):
		body.set_brush_color(color)


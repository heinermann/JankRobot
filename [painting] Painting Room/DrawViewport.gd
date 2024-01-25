extends SubViewport

@onready var brush: Node2D = $Brush

func paint(position: Vector2, colour: Color, brush_size: int, texture: Texture2D):
	brush.queue_brush(position * 512, colour, brush_size, texture)

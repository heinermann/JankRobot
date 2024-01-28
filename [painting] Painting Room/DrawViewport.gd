extends SubViewport

@onready var brush: Node2D = $Brush

@export var brush_size: int = 10

func _ready():
	set_clear_mode(SubViewport.CLEAR_MODE_ONCE)


func paint(position: Vector2, colour: Color, texture: Texture2D):
	brush.queue_brush(position * get_texture().get_height(), colour, brush_size, texture)

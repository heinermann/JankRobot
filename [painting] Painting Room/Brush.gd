extends Node2D
 

var brush_queue = []
 
func queue_brush(position: Vector2, colour: Color, brush_size: int, texture: Texture2D,):
	brush_queue.push_back([position, colour, brush_size, texture])
	queue_redraw()
 
func _draw():
	for b in brush_queue:
		var brush_size = b[2]
		var texture = b[3]
		draw_texture_rect(texture, Rect2(b[0].x - brush_size/2, b[0].y - brush_size/2, brush_size, brush_size), false, b[1])
	brush_queue = []
 

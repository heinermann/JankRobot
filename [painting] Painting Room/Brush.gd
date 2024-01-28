extends Node2D
 

var brush_queue = []
 
func queue_brush(position: Vector2, colour: Color, texture: Texture2D):
	brush_queue.push_back({
		position = position,
		colour = colour,
		texture = texture
	})
	queue_redraw()
 
func _draw():
	for b in brush_queue:
		var rect = Rect2(b.position - b.texture.get_size()/2, b.texture.get_size())
		draw_texture_rect(b.texture, rect, false, b.colour)
	brush_queue = []
 

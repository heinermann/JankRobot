extends HSlider
signal mood_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("value_changed", _on_value_changed)
	
func _on_value_changed(mood):
	emit_signal("mood_changed", mood)

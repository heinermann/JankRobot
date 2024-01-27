extends HSlider
signal mood_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("value_changed", _on_value_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_value_changed(value):
	emit_signal("mood_changed", value)

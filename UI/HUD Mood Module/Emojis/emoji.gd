extends Sprite2D
@export var mood_placeholder: HSlider = null
func _ready():
	mood_placeholder.connect("mood_changed", _on_mood_changed)
	frame = 0

func _on_mood_changed(mood): # mood is a numeral measurement for the mood of scientist
	# 00-25 frustrated
	# 25-50 stressed
	# 50-75 confused
	# 75-100 happy
	frame = clamp(hframes - int(mood) / 25 - 1, 0, hframes - 1)

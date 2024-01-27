extends Control
var previous_mood := 100
@onready var animator: AnimationPlayer = $gauge/AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	$mood_placeholder.connect("mood_changed", _on_mood_changed)
	var gauge_sprite: Sprite2D = $gauge
	gauge_sprite.frame = gauge_sprite.hframes - 1

func _on_mood_changed(mood): # mood is a numeral measurement for the mood of scientist
	print("current mood value: ", mood)
	var ranges: Array = [[0, 24],[25, 49],[50, 74],[75, 100]]
	# 00-25 frustrated
	# 25-50 stressed
	# 50-75 confused
	# 75-100 happy
	for range in ranges:
		var start = range[0]
		var end = range[1]
		if (mood >= start and mood <= end) and (previous_mood >= start and previous_mood <= end):
			previous_mood = mood
			return
	if mood <= 25:
		if previous_mood < mood:
			animator.play("frustrated_to_stressed")
		else:
			animator.play_backwards("frustrated_to_stressed")
	elif mood <= 50:
		if previous_mood < mood:
			animator.play("stressed_to_confused")
		else:
			animator.play_backwards("stressed_to_confused")
	elif mood <= 75:
		if previous_mood < mood:
			animator.play("confused_to_happy")
		else:
			animator.play_backwards("confused_to_happy")
	previous_mood = mood
			

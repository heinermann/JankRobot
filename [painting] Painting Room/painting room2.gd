extends Node3D

var finished_game: bool = false

@export var decrease_mood_over_time: bool = true
@export var mood_down_over_time: float

var mood: float = 100.0

@export var max_time_in_seconds: float
var current_time: float = 0

@onready var slider: HSlider = get_node("MoodModule/mood_placeholder")

# Called when the node enters the scene tree for the first time.
func _ready():

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Scientist/AnimationPlayer.play("idle")
	$Level/Fans/RoomFan/AnimationPlayer.play("Fan")
	$Level/Fans/RoomFan2/AnimationPlayer.play("Fan")
	$Level/Fans/RoomFan3/AnimationPlayer.play("Fan")
	$Level/Fans/RoomFan4/AnimationPlayer.play("Fan")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	current_time += delta
	if current_time > max_time_in_seconds:
		finish_game()
		
	if current_time > max_time_in_seconds / 2:
		decrease_mood_over_time = true
		
	if !finished_game and decrease_mood_over_time:
		mood -= mood_down_over_time * delta
		slider.value = mood
		
	if Input.is_action_just_pressed("ui_page_down"):
		finish_game()
	

func finish_game():
	finished_game = true
	var exists = get_node_or_null("/root/PaintingRoom/ResultsMenu")
	if !exists:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		var results_menu = load("res://UI/Menus/ResultsMenu/results_menu.tscn")
		var instance = results_menu.instantiate()
		instance.score = $canvas.get_score()
		add_child(instance)

extends Node
@onready var players: Array[Node]
@onready var subviewport1 : SubViewportContainer
@onready var subviewport2 : SubViewportContainer
@onready var screen: GridContainer
var main_camera: Camera3D
var delay = 0.3
var timer = 0.0
func _ready():
	players = get_tree().get_nodes_in_group("players")
	subviewport1 = $SplitScreen/SubViewportContainer
	subviewport2 = $SplitScreen/SubViewportContainer2
	subviewport1.visible = true
	subviewport2.visible = true
	screen = $SplitScreen

func _process(delta):
	var num_of_centered_cameras = 0
	timer += delta
	if timer > delay:
		for item in players:
			if not item.is_class("RigidBody3D"): continue
			var pivot = item.get_node("TwistPivot")
			if abs(pivot.rotation.y) > deg_to_rad(20) * 0.95:
				num_of_centered_cameras += 1 
		if num_of_centered_cameras == players.size() - 1:
			if subviewport2.visible == true:
				subviewport2.visible = false
				screen.columns = 1
		else:
			if subviewport2.visible == false:
				subviewport2.visible = true;
				screen.columns = 2
		timer = 0

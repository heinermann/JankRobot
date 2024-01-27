extends RigidBody3D
# Tutorial @ https://www.youtube.com/watch?v=gPVXwwvxlzs


var original_parent: Node
var picked_up_by: Node = null
var original_collision_mask
var original_collision_layer

func _ready():
	original_parent = self.get_parent()
	original_collision_mask = self.collision_mask
	original_collision_layer = self.collision_layer

func pick_up(by):
	if picked_up_by == by: return
	if picked_up_by: let_go()
	
	picked_up_by = by
	
	self.collision_mask = 0
	self.collision_layer = 0
	self.freeze = true
	
	self.get_parent().remove_child(self)
	picked_up_by.find_child("AttachmentPoint").add_child(self)
	
	self.transform = Transform3D()

func let_go():
	if not picked_up_by: return
	
	var pos = self.global_transform
	
	self.get_parent().remove_child(self)
	original_parent.add_child(self)
	
	self.freeze = false
	self.global_transform = pos
	self.collision_mask = original_collision_mask
	self.collision_layer = original_collision_layer
	
	picked_up_by = null

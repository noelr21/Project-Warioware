extends Node2D

# Variables for Map indexes as int
var leftDoorIndex setget set_leftDoorIndex
var rightDoorIndex setget set_rightDoorIndex
# Nodes for the left door and right door destinations
var ldDes setget set_ldDes
var rdDes setget set_rdDes
# Setter methods
func set_ldDes(value):
	ldDes = value

func set_rdDes(value):
	rdDes = value

func set_leftDoorIndex(value):
	if value <= 0:
		print("Paramater: value, was invalid at Function: set_leftDoorIndex in room.gd script")
		leftDoorIndex = 1
	else:
		leftDoorIndex = value

func set_rightDoorIndex(value):
	if value <= 0:
		print("Paramater: value, was invalid at Function: set_rightDoorIndex in room.gd script")
		rightDoorIndex = 1
	else:
		rightDoorIndex = value

# Move player to room on the left
func _on_RightDoor_body_entered(body):
	print("RightDoorEntered from Function: _on_RightDoor_body_entered in room.gd script")
	body.move_between_rooms(rdDes, rightDoorIndex)

# Move player to room on the right
func _on_LeftDoor_body_entered(body):
	print("LeftDoorEntered: from Function: _on_LeftDoor_body_entered in room.gd script")
	body.move_between_rooms(ldDes, leftDoorIndex)

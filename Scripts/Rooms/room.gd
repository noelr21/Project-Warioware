extends Node2D

#Variables for the door objects
onready var leftDoor = $LeftDoor
onready var rightDoor = $RightDoor
#Variables for the linked doors
#Note: This will be hardcoded for now but eventually will be assigned by the 
export(NodePath) var leftDoorDestination;
export(NodePath) var rightDoorDestination;
export(int) var leftDoorIndex;
export(int) var rightDoorIndex;
onready var ldDes = get_node(leftDoorDestination)
onready var rdDes = get_node(rightDoorDestination)

#Move player to room on the left
func _on_RightDoor_body_entered(body):
	print("RightDoorEntered")
	body.move_between_rooms(rdDes, rightDoorIndex)

#Move player to room on the right
func _on_LeftDoor_body_entered(body):
	print("LeftDoorEntered")
	body.move_between_rooms(ldDes, leftDoorIndex)


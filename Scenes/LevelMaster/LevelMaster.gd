extends Node2D

# Holds an array of all nodePaths for all rooms
export(Array, NodePath) var roomNodePaths
# Holds an array of room nodePaths that define what rooms each door goes to
# [room 1: [leftDoorDes(i.e. other room right door), rightDoorDes(i.e. other room left door)] room 2: [leftDoorDes, rightDoorDes]]
export(Array, Array, NodePath) var doorNodePaths
# Arrays of rooms and the destinations of their doors related by index
var rooms = []
var doorPaths = []

func _ready():
	init_rooms()
	init_door_paths()
	init_room_nodes()

# Populate rooms array with actual nodes by getting rooms in nodePaths
func init_rooms():
	for roomNodePath in roomNodePaths:
		rooms.push_back(get_node(roomNodePath))

# Populate doorPaths with appropriate Door nodes 
func init_door_paths():
	var x = 0
	for roomNodePath in doorNodePaths:
		var y = 0
		doorPaths.push_back([])
		for nodepath in roomNodePath:
			doorPaths[x].push_back(get_node(get_string_from_nodepath(nodepath)+("/RightDoor" if y == 0 else "/LeftDoor")))
			y += 1
		x += 1

# Set relations between rooms using data in relations defined in doorPaths
func init_room_nodes():
	var roomIndex = 1
	for room in rooms:
		room.ldDes = doorPaths[roomIndex - 1][0]
		room.rdDes = doorPaths[roomIndex - 1][1]
		room.leftDoorIndex = roomIndex - 1 if (roomIndex - 1) > 0 else rooms.size()
		room.rightDoorIndex = roomIndex + 1 if (roomIndex + 1) <= rooms.size() else 1
		roomIndex += 1

# Takes in a nodepath and turns it into a string. ref NodePath documentation
func get_string_from_nodepath(nodepath):
	var string = ""
	for i in nodepath.get_name_count():
		string += nodepath.get_name(i)+("/" if i != nodepath.get_name_count()-1 else "")
	return string

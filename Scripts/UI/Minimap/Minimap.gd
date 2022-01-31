extends Control

export(int) var startingFrame = 1;

onready var minimap = $Minimap

func changeRooms(roomIndex):
	minimap.frame = roomIndex

func _ready():
	changeRooms(startingFrame)


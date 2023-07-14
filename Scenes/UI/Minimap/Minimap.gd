extends Control

@export var startingFrame: int = 1;

@onready var minimap = $Minimap

func changeRooms(roomIndex):
	minimap.frame = roomIndex

func _ready():
	changeRooms(startingFrame)


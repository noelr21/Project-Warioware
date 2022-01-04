extends Sprite

onready var leftDoor = $LeftDoor
onready var rightDoor = $RightDoor
const Chungus = preload("res://Sprites/Chungus.tscn")

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_left"):
		spawn_chungus(leftDoor)
	elif Input.is_action_just_pressed("ui_right"):
		spawn_chungus(rightDoor)

func _on_RightDoor_area_entered(area:Area2D):
	spawn_chungus(area)

func _on_LeftDoor_area_entered(area:Area2D):
	spawn_chungus(area)

func spawn_chungus(area):
	var chungus = Chungus.instance()
	get_parent().add_child(chungus)
	print(area.global_position)
	chungus.global_position = area.global_position

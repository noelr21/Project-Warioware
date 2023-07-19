extends CharacterBody2D

@export var ACCELERATION = 500
@export var MAX_SPEED = 80
@export var FRICTION = 500

var vel = Vector2.ZERO # velocity
var roll_vector = Vector2.DOWN

@onready var animationPlayer = $AnimationPlayer

# Get minimap
@onready var minimap = get_tree().get_root().get_child(0).get_node("UI/Minimap")

#Control whether the player can move between rooms or not
var canChangeRooms = true: get = get_canChangeRooms, set = set_canChangeRooms

func set_canChangeRooms(val):
	canChangeRooms = val

func get_canChangeRooms():
	return canChangeRooms

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		vel = vel.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		vel = vel.move_toward(Vector2.ZERO, FRICTION * delta)

	move() 

func move():
	set_velocity(vel)
	move_and_slide()
	queue_redraw()
	vel = vel #move_and_slide returns the velocity left over from the collision and set it to the velocity

# Moves the player between rooms
func move_between_rooms(destination, roomIndex):
	if(canChangeRooms):
		global_position = destination.global_position
		minimap.changeRooms(roomIndex) #Change current room on minimap
		
func _draw():
	draw_circle(Vector2.ZERO, 60, Color(Color.PINK, 0.50))

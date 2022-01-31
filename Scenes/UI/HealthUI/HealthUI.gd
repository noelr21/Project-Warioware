extends Control

#TODO create support for different types of hearts

var health = 4 setget set_health
var max_health = 4 setget set_max_health

onready var healthNodeEmpty = $HealthNodeEmpty
onready var healthNodeFull = $HealthNodeFull
onready var healthBarEnd = $HealthBarEnd

export(bool) var debug = false

func set_health(value):
	health = clamp(value, 0, max_health)
	# Make sure healthNodeFull is assigned
	if healthNodeFull != null:
		healthNodeFull.rect_size.x = health * 6  # Add another full health node. Equation logic: health(amount of nodes) * 6(x size of node sprite)

func set_max_health(value):
	max_health = max(value, 1)
	self.health = min(health, max_health) # Making sure health never goes higher than max health
	# Make sure healthNodeEmpty is assigned
	if healthNodeEmpty != null:
		healthNodeEmpty.rect_size.x = max_health * 6  # Add another empty health node. Equation logic: max_health(amount of nodes) * 6(x size of node sprite)
		set_healthbar_end_position()

func set_healthbar_end_position():
	if healthBarEnd != null:
		healthBarEnd.rect_position.x = max_health * 6 + 14 	# Move the health bar to fit new health nodes. Equation logic: max_health(amount of nodes) * 6(x size of node sprite) + 14(x size of bar start sprite)

func _ready():
	self.health = health
	self.max_health = max_health

func _physics_process(_delta):
	if !debug:
		return
	if Input.is_action_just_pressed("debug_up"):
		set_max_health(max_health + 1)
	elif Input.is_action_just_pressed("debug_down"):
		set_max_health(max_health - 1)
	if Input.is_action_just_pressed("debug_right"):
		set_health(health + 1)
	elif Input.is_action_just_pressed("debug_left"):
		set_health(health - 1)


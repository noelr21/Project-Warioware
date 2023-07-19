extends CharacterBody2D

@export var ACCELERATION = 300
@export var MAX_SPEED = 50
@export var FRICTION = 200
@export var HOVERDISTANCE = 16
@export var MINMOVEDISTANCE = 10
var MIN_DISTANCE = Vector2(0.75,0.75)

enum{
	IDLE, 
	WANDER,
	CHASE,
	HOVER
}

var knockback = Vector2.ZERO

var state = IDLE

@onready var sprite = $Sprite2D
@onready var stats = $Stats
@onready var playerDetectionZone = $PlayerDetectionZone

func findAngle(pointOne : Vector2, pointTwo : Vector2):
	return atan2(pointTwo.y - pointOne.y, pointTwo.x - pointOne.x)

func findPointOnCircle(angle, radius, center_coords):
	var x = cos(angle) * radius + center_coords.x
	var y = sin(angle) * radius + center_coords.y
	return Vector2(x, y) 

func isCloseToTarget(current_pos, target_pos):
	var xDistance = current_pos.x >= target_pos.x - MINMOVEDISTANCE && current_pos.x <= target_pos.x + MINMOVEDISTANCE
	var yDistance = current_pos.y >= target_pos.y - MINMOVEDISTANCE && current_pos.y <= target_pos.y + MINMOVEDISTANCE
	return xDistance && yDistance
func _ready():
	velocity = Vector2.ZERO

var debugDirection
var target_position : Vector2
var target_set = false
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				if isCloseToTarget(global_position, target_position):
					state = HOVER
				var angle = findAngle(player.global_position, global_position)
				target_position = findPointOnCircle(angle, HOVERDISTANCE, player.global_position)
				target_set = true
				var direction = (target_position - global_position).normalized()
				debugDirection = direction
				queue_redraw()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				target_set = false
				queue_redraw()
				state = IDLE
		HOVER:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			var player = playerDetectionZone.player
			if player != null:
				var angle = findAngle(player.global_position, global_position)
				if !isCloseToTarget(target_position, findPointOnCircle(angle, HOVERDISTANCE, player.global_position)):
					state = CHASE
			else:
				state = IDLE
	sprite.flip_h = velocity.x < 0 
	set_velocity(velocity)
	move_and_slide()
	velocity = velocity
	
func _draw():
	if playerDetectionZone.player:
		draw_line(Vector2.ZERO, playerDetectionZone.player.global_position - global_position, Color(Color.WHITE, 0.5), 2)
	if target_set:
		draw_circle(target_position - global_position, 5, Color.RED)
		draw_circle(debugDirection * 20, 5, Color.BLUE)

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func _on_Hurtbox_area_entered(area:Area2D):
	stats.health -= area.damage #Call down i.e. this calls the set method for health on stats
	knockback = area.knockback_vector * 160

# This is the signal receiving information from 
func _on_Stats_no_health():
	queue_free()
#	var enemyDeathEffect = EnemyDeathEffect.instantiate()
#	get_parent().add_child(enemyDeathEffect)
#	enemyDeathEffect.global_position = global_position

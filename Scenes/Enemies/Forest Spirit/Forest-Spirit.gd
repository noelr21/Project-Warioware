extends CharacterBody2D

@export var ACCELERATION = 300
@export var MAX_SPEED = 50
@export var FRICTION = 200

enum{
	IDLE, 
	WANDER,
	CHASE
}

var knockback = Vector2.ZERO

var state = IDLE

@onready var sprite = $Sprite2D
@onready var stats = $Stats
@onready var playerDetectionZone = $PlayerDetectionZone

func _ready():
	velocity = Vector2.ZERO

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
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
	sprite.flip_h = velocity.x < 0 
	set_velocity(velocity)
	move_and_slide()
	velocity = velocity

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

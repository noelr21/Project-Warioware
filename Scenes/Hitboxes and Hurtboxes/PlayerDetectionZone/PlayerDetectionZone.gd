extends Area2D

var player = null
var lineOfSight = false
var playerFound = false

func can_see_player():
	return lineOfSight

func _on_PlayerDetectionZone_body_entered(body:Node):
	print("Player was detected")
	player = body
func _on_PlayerDetectionZone_body_exited(_body:Node):
	print("Player has left the detection zone")
	player = null
	lineOfSight = false
	playerFound = false
	
#if player enters the detection zone check to see if they are in line of sight and if found do not forget them as
#as long as they are in the detection zone
func _physics_process(_delta):
	if player != null && !playerFound:
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(self.global_position, player.position)
		var result = space_state.intersect_ray(query)
		#if no result leave
		if result == null || result.is_empty():
			return
		print("result: ", result)
		print("Object hit in raycast: ")
		print(result.collider)
		if result.collider == player:
			lineOfSight = true
			playerFound = true

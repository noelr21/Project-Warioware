extends Area2D

var player = null

func can_see_player():
	return player != null

func _on_PlayerDetectionZone_body_entered(body:Node):
	console.log("Player was detected")
	player = body
func _on_PlayerDetectionZone_body_exited(_body:Node):
	console.log("Player has left the detection zone")
	player = null

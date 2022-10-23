extends Area2D

var player = null

func can_see_player():
	return player != null

func _on_PlayerDetectionZone_body_entered(body:Node):
	print("Player was detected. Location: PlayerDetectionZone.gd/_on_PlayerDectectionZone_body_entered")
	player = body
func _on_PlayerDetectionZone_body_exited(_body:Node):
	print("Player has left the detection zone. Location: PlayerDetectionZone.gd/_on_PlayerDectectionZone_body_exited")
	player = null

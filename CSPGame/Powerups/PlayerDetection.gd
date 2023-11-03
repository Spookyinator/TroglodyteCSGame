extends Area2D

var player = null
signal powerup_consumed
func _on_body_entered(body):
	# Add code to kill all the zombies here
	player = body
	powerup_consumed.emit()

func _on_body_exited(body):
	player = null

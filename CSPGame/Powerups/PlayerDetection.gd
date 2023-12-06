extends Area2D

var player = null
signal powerup_consumed
func _on_body_entered(body):
	# Add code to kill all the zombies here
	var powerup = get_parent().get_child(0).name
	player = body
	powerup_consumed.emit(powerup)

func _on_body_exited(body):
	player = null

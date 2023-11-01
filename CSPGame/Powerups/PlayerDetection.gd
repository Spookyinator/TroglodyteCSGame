extends Area2D

var player = null

func _on_body_entered(body):
	# Add code to kill all the zombies here
	get_parent().queue_free()

func _on_body_exited(body):
	player = null

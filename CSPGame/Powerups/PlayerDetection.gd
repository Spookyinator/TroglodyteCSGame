extends Area2D

var player = null

func _on_body_entered(body):
	print("test")
	get_parent().queue_free()

func _on_body_exited(body):
	player = null

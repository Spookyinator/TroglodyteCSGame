extends Area2D

var player = null

func _on_body_entered(body):
	player = body
	print("test")

func _on_body_exited(body):
	player = null

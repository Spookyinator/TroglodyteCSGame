extends Area2D
var cameraA: Camera2D
var cameraB: Camera2D

func _ready():
	cameraA = $"../Camera2D"
	cameraB = $"../Camera2D2"
	cameraA.set_process(true)
func _on_body_entered(body):
	switch_cameras()
	print("entered")
func switch_cameras():
	cameraA.set_process(false)
	cameraB.set_process(true)
	
func _on_body_exited(body):
	print("exited")

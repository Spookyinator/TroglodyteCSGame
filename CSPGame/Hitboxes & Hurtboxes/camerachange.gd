extends Area2D
var cameraA: Camera2D
var cameraB: Camera2D

func _ready():
	cameraA = $"../Camera2D"
	cameraB = $"../Camera2D2"
	cameraA.set_process(true)
	pass
func _on_body_entered(body):
	switch_cameras()
	print("entered")
func switch_cameras():
	if cameraA.is_current():
		cameraB.make_current()
	else:
		cameraA.make_current()

func _on_body_exited(body):
	print("exited")

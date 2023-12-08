extends RigidBody2D
var player = null
var points = 0

@onready var label = $Label


func _ready(): 
	label.visible = false
func _physics_process(delta):
	if Input.is_action_just_pressed("interact") and label.visible == true:
		label.visible = false

func _on_body_entered(body):
	label.visible = true
	player = body


func _on_body_exited(body):
	label.visible = false

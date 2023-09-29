extends CharacterBody2D


const SPEED = 300.0

func _physics_process(delta):
	
	var directionx = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	var directiony = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	
	if directionx:
		velocity.x = SPEED * directionx
	else:
		velocity.x = lerp(SPEED, 0.0, 1.0)
	if directiony:
		velocity.y = SPEED * directiony
	else:
		velocity.y = lerp(SPEED, 0.0, 1.0)
	move_and_slide()

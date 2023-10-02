extends CharacterBody2D


const SPEED = 75.0
const slideSPEED = 300.0

enum STATE {MOVE, SLIDE, SHOOTING}

var _state : int = STATE.MOVE

var shooting = false
var sliding = false

func _physics_process(delta):
	var directionx = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	var directiony = Input.get_action_strength("Down") - Input.get_action_strength("Up") 
	
	if Input.is_action_just_pressed("slide"):
		pass
	
	if shooting and sliding == false:
		_state = STATE.MOVE
	
	if _state == STATE.MOVE:

		if directionx:
			velocity.x = SPEED * directionx
		else:
			velocity.x = lerp(SPEED, 0.0, 1.0)
		if directiony:
			velocity.y = SPEED * directiony
		else:
			velocity.y = lerp(SPEED, 0.0, 1.0)
		
	move_and_slide()

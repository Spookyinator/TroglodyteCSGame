extends CharacterBody2D


const SPEED = 65.0
const slideSPEED = 130.0

enum STATE {MOVE, SLIDE, SHOOT}

var _state : int = STATE.MOVE

var shooting = false

var sliding = false

func _physics_process(delta):
	var directionx = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	var directiony = Input.get_action_strength("Down") - Input.get_action_strength("Up") 
	
	if Input.is_action_just_pressed("slide"):
		_state = STATE.SLIDE
		$SlideTimer.start()
	
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
	
	if _state == STATE.SLIDE:
		if directionx:
			velocity.x = slideSPEED * directionx
		
	move_and_slide()


func _on_slide_timer_timeout():
	_state = STATE.MOVE

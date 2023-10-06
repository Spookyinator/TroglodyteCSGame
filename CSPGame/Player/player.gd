extends CharacterBody2D


const SPEED = 65.0
const slideSPEED = 130.0
const bullet_speed = 500.0
const shooting_speed = 50.0

enum STATE {MOVE, SLIDE, SHOOT}

var _state : int = STATE.MOVE

var shooting = false
var sliding = false

var bullet  = preload("res://Weapons/bullet.tscn")

@onready var chamber = $Chamber

func _physics_process(delta):
	var directionx = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	var directiony = Input.get_action_strength("Down") - Input.get_action_strength("Up") 
	
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
	
	if Input.is_action_pressed("shoot") and sliding == false:
		shooting = true
		shoot()
	else:
		shooting = false
	
	if shooting == true:
		_state = STATE.SHOOT
	
	if _state == STATE.SHOOT:
		print("yes")
		if directionx:
			velocity.x = shooting_speed * directionx
		else:
			velocity.x = lerp(shooting_speed, 0.0, 1.0)
		if directiony:
			velocity.y = shooting_speed * directiony
		else:
			velocity.y = lerp(shooting_speed, 0.0, 1.0)
	
	if Input.is_action_just_pressed("slide"):
		_state = STATE.SLIDE
		$SlideTimer.start()
		set_process_unhandled_input(false)
	
	if _state == STATE.SLIDE:
		sliding = true
		if directionx:
			velocity.x = slideSPEED * directionx
		if directiony:
			velocity.y = slideSPEED * directiony
			
	
	look_at(get_global_mouse_position())
	move_and_slide()

func shoot():
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = chamber.global_position
	bullet_instance.rotation = global_rotation
	bullet_instance.apply_impulse(Vector2(bullet_speed, 0).rotated(bullet_instance.rotation),Vector2())
	get_tree().get_root().add_child(bullet_instance)
	bullet_instance.get_node("Timer").start()

func _on_slide_timer_timeout():
	_state = STATE.MOVE
	sliding = false

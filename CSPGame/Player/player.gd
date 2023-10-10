extends CharacterBody2D
signal playerDead

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
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	direction.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	direction = direction.normalized()
	
	if shooting and sliding == false:
		_state = STATE.MOVE
	
	if _state == STATE.MOVE:
		if direction:
			velocity = SPEED * direction
		else:
			velocity.y = lerp(SPEED, 0.0, 1)
			velocity.x = lerp(SPEED, 0.0, 1)
			
	if Input.is_action_just_pressed("shoot") and sliding == false:
		shooting = true
		shoot()
	else:
		shooting = false
	
	if shooting == true:
		_state = STATE.SHOOT
	
	if _state == STATE.SHOOT:
		if direction.x:
			velocity.x = shooting_speed * direction.x
		else:
			velocity.x = lerp(shooting_speed, 0.0, 1.0)
		if direction.y:
			velocity.y = shooting_speed * direction.y
		else:
			velocity.y = lerp(shooting_speed, 0.0, 1.0)
	
	if Input.is_action_just_pressed("slide"):
		_state = STATE.SLIDE
		$SlideTimer.start()
		set_process_unhandled_input(false)
	
	if _state == STATE.SLIDE:
		sliding = true
		if direction.x:
			velocity.x = slideSPEED * direction.x
		if direction.y:
			velocity.y = slideSPEED * direction.y
		
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

func _on_hitbox_no_health():
	playerDead.emit()
	queue_free()

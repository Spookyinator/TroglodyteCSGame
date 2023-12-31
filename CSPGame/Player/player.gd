extends CharacterBody2D
signal player_dead
signal instakill_zombies
signal shield_on
signal shield_off
const SPEED = 120.0
const slideSPEED = 195.0
const bullet_speed = 2000.0
const shooting_speed = 200.0

enum STATE {MOVE, SLIDE, SHOOT}

var _state : int = STATE.MOVE

var shooting = false
var sliding = false

var stamina = 100.0
var stamina_regening = false
var stamina_timer = false

var health_regen = false
var can_heal = true

var bullet  = preload("res://Weapons/bullet.tscn")
var game_over = preload("res://Screens/gameOver.tscn")

var points = 0
var gun_level = 0

@onready var pivot = $Pivot
@onready var chamber = $Pivot/Chamber
@onready var stamina_bar = $StaminaBar
@onready var stamina_reg = $StaminReg
@onready var player_skin = $PlayerFrame1
@onready var hitbox = $Hitbox
@onready var health_bar = $CanvasLayer/HealthBar
@onready var health_timer = $HealthReg
@onready var instakill_countdown = $CanvasLayer/InstaKillCountdown
@onready var instakill_timer = $InstaKillTimer
@onready var instakill_display = $CanvasLayer/InstaKillDisplay
@onready var shield_countdown = $CanvasLayer/ShieldCountdown
@onready var shield_timer = $ShieldTimer
@onready var shield_display = $CanvasLayer/ShieldDisplay
const GUN_TYPES = ["Pistol","Shotgun","SMG"]

var powerup_states = {"instakill": false, "shield": false}
@onready var powerup_displays = {"instakill": instakill_display, "shield": shield_display}
@onready var powerup_countdowns = {"instakill": instakill_countdown, "shield": shield_countdown}
@onready var powerup_timers = {"instakill": instakill_timer, "shield": shield_timer}
@onready var powerup_events = {"instakill": instakill_zombies, "shield": shield_on}

func _ready():
	instakill_display.visible = false
	shield_display.visible = false
func _physics_process(delta):
	stamina_bar.value = stamina
	if stamina >= 100:
		stamina_bar.visible = false
		stamina_regening = false
	if stamina <= 99:
		stamina_bar.visible = true
	
	if stamina_regening == true:
		stamina += 0.5
	
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

	if Input.is_action_pressed("slide") and stamina >= 1:
		stamina_regening = false
		_state = STATE.SLIDE
		set_process_unhandled_input(false)
	else:
		sliding = false
		_state = STATE.MOVE
	
	if _state == STATE.SLIDE:
		stamina -= 1
		sliding = true

		if direction.x:
			velocity.x = slideSPEED * direction.x
		if direction.y:
			velocity.y = slideSPEED * direction.y
		
	if stamina <= 99 and sliding == false and stamina_timer == false:
		_state = STATE.MOVE
		stamina_reg.start()
		stamina_timer = true
		
	if hitbox.health >= hitbox.max_health:
		health_regen = false
		can_heal = true
	if hitbox.health < hitbox.max_health and health_regen == false and can_heal == true:
		health_timer.start()
		can_heal = false
		print(hitbox.health)
	if health_regen == true:
		hitbox.health += .01
		
	pivot.look_at(get_global_mouse_position())
	player_skin.rotation_degrees = pivot.rotation_degrees + 270
	move_and_slide()
	update_health()
	update_powerup_timer()

func shoot():
	var bullet_instance = bullet.instantiate()
	var hurtbox = bullet_instance.get_node("Hurtbox")
	if (not powerup_states["instakill"]):
		if (not gun_level == 0):
			hurtbox.damage = gun_level*1.5
	else:
		hurtbox.damage = hurtbox.INSTANT_DEATH
	bullet_instance.position = chamber.global_position
	bullet_instance.rotation = pivot.global_rotation
	bullet_instance.apply_impulse(Vector2(bullet_speed, 0).rotated(bullet_instance.rotation),Vector2())
	get_tree().get_root().add_child(bullet_instance)
	bullet_instance.get_node("Timer").start()

func _on_hitbox_no_health():
	player_dead.emit()
	queue_free()
	
func _on_stamin_reg_timeout():
	stamina_regening = true
	
func on_get_points(pointsGiven):
	points += pointsGiven
func update_health():
	health_bar.max_value = hitbox.max_health
	health_bar.value = hitbox.health

func _on_health_reg_timeout():
	health_regen = true
	health_timer.stop()

func _on_hitbox_hit():
	health_regen = false
	can_heal = true

func get_upgrade(gun_type,upgrade_level):
	print("Gun %s upgraded to level %d" % [GUN_TYPES[gun_type],upgrade_level])
	gun_level = upgrade_level

func activate_powerup(powerup):
	powerup_states[powerup] = true
	powerup_timers[powerup].start()
	powerup_displays[powerup].visible = true
	powerup_countdowns[powerup].visible = true
	powerup_events[powerup].emit()
	print("%s ACTIVATED!" % powerup.to_upper())
	
func deactivate_powerup(powerup):
	print("%s DEACTIVATED!" % powerup.to_upper())
	powerup_states[powerup] = false;
	powerup_countdowns[powerup].visible = false;
	powerup_displays[powerup].visible = false
	
func _on_insta_kill_timeout():
	deactivate_powerup("instakill")
func _on_shield_timer_timeout():
	deactivate_powerup("shield")
	shield_off.emit()
func update_powerup_timer():
	for powerup in powerup_states:
		if (powerup_states[powerup]):
			var timeLeft: int = powerup_timers[powerup].time_left
			powerup_countdowns[powerup].text = "%d" % timeLeft

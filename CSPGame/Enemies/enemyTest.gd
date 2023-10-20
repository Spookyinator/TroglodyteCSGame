extends CharacterBody2D

const SPEED = 40.0
const ATKRANGE = 15.0
const KILLPOINTS = 100
const HITPOINTS = 10
enum state {follow, attack}

@onready var skin = $Skin

var player = null

var gameOver = false

signal isKilled

func _on_detection_body_entered(body):
	player = body
	
func _on_detection_body_exited(body):
	player = null

func _physics_process(_delta):
	if player != null:
		var distance = position.distance_to(player.global_position)
		if distance<ATKRANGE:
			stop()
		else:
			distance = position.distance_to(player.global_position)
			target(player.global_position)
	update_health()

func update_health():
	var hitbox = $Hitbox
	var health = hitbox.health
	var max_health = hitbox.max_health
	var health_bar = $HealthBar
	var health_percent = health/max_health
	if health >= 1:
		health_bar.value = health_percent * 100
	if health <= 0:
		health_bar.value = 0

func _on_hitbox_no_health():
	isKilled.emit(KILLPOINTS)
	queue_free()

@warning_ignore("unused_parameter")
func _on_zombie_hit(area):
	isKilled.emit(HITPOINTS) # Replace with function body.


func target(targetPos):
	velocity = position.direction_to(targetPos) * SPEED
	skin.look_at(targetPos)
	move_and_slide()

func stop():
	velocity = Vector2.ZERO
	move_and_slide()

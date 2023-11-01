extends CharacterBody2D

const SPEED = 40.0
const ATKRANGE = 15.0
const KILLPOINTS = 100
const HITPOINTS = 10
enum state {follow, attack}

@onready var skin = $Skin
@onready var playerDetection = $PlayerDetection

var player = null

var gameOver = false

signal isKilled
signal isHit
func _physics_process(_delta):
	player = playerDetection.player
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
	health_bar.max_value = max_health
	health_bar.value = health

func _on_hitbox_no_health():
	isKilled.emit(KILLPOINTS, position.x, position.y)
	queue_free()

@warning_ignore("unused_parameter")
func _on_zombie_hit(area):
	isHit.emit(HITPOINTS) # Replace with function body.


func target(targetPos):
	velocity = position.direction_to(targetPos) * SPEED
	skin.look_at(targetPos)
	move_and_slide()

func stop():
	velocity = Vector2.ZERO
	move_and_slide()
func _on_player_detection_body_entered(body):
	pass
func _on_player_detection_body_exited(body):
	pass



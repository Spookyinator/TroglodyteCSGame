extends CharacterBody2D

const SPEED = 40.0
const ATKRANGE = 15.0
const KILLPOINTS = 100
const HITPOINTS = 10
enum state {follow, attack}

@onready var skin = $Skin

var player = null
#var canMove = true
var gameOver = false

signal isKilled
func _ready():
	if not gameOver:
		player = get_node("/root/Level/Player")
	else:
		queue_free()
		print("GAME OVER YEAHHHHH")
func _handlePlayerDead():
	gameOver = true
func target(targetPos):
	#velocity = Vector2.ZERO
	velocity = position.direction_to(player.position) * SPEED
	#var distance = position.distance_to(player.global_position)
	#print("Velocity: "+str(movement_vector))
	#print("dist from player:"+str(distance))
	skin.look_at(targetPos)
	move_and_slide()
	
func stop():
	velocity = Vector2.ZERO
	move_and_slide()

func _physics_process(_delta):
	var _state = state.follow
	if not gameOver:
		if (not player == null):
			var distance = position.distance_to(player.global_position)
			if distance<ATKRANGE:
				stop()
				_state = state.attack
			else:
				distance = position.distance_to(player.global_position)
				target(player.global_position)
				_state = state.follow
	else:
		print("GAME OVER YEAHHHHH")
		queue_free()
		
		
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
	


func _on_player_player_dead():
	gameOver = true


func _on_zombie_hit(area):
	isKilled.emit(HITPOINTS) # Replace with function body.

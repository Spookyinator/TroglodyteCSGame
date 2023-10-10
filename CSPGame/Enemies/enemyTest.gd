extends CharacterBody2D

const SPEED = 40.0
const ATKRANGE = 15.0

enum state {follow, attack}

@onready var skin = $Skin

var player = null
var canMove = true
var gameOver = false
func _ready():
	player = get_node("/root/Level/Player")
	#player.playerDead.connect(_handlePlayerDead())
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
	update_health()

func update_health():
	var hitbox = $Hitbox
	var health = hitbox.health
	var health_bar = $HealthBar
	health_bar.value = health * 6.66666667
	
	if health >= 100:
		health_bar.visible = false
	else:
		health_bar.visible = true

func _on_hitbox_no_health():
	queue_free()
	

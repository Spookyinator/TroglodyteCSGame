extends CharacterBody2D

const SPEED = 40.0
const ATKRANGE = 15.0

enum state {follow, attack}

var player = null
#var canMove = true
var gameOver = false
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
	look_at(targetPos)
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
		queue_free()
		
		
func _on_hitbox_no_health():
	queue_free()
	


func _on_player_player_dead():
	gameOver = true
	queue_free()

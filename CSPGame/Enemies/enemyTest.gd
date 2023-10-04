extends CharacterBody2D


const SPEED = 40.0
const ATKRANGE = 50.0
var player = null
var canMove = true
func _ready():
	player = get_node("/root/Level/Player")
func target(targetPos):
	#velocity = Vector2.ZERO
	velocity = position.direction_to(player.position) * SPEED
	#var distance = position.distance_to(player.global_position)
	#print("Velocity: "+str(movement_vector))
	#print("dist from player:"+str(distance))
	move_and_slide()
func stop():
	velocity = Vector2.ZERO
	move_and_slide()

func _physics_process(_delta):
	var distance = position.distance_to(player.global_position)
	if distance<ATKRANGE:
		stop()
	else:
		distance = position.distance_to(player.global_position)
		target(player.global_position)
		

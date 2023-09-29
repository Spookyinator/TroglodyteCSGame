extends CharacterBody2D


const SPEED = 25.0
var player = null
func _ready():
	player = get_node("/root/Level/Player")
func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if player:
		var targetPos = player.position
		var distance = self.global_position.distance_to(player.global_position)
		var movement_vector = position.move_toward(targetPos, SPEED)
		velocity = movement_vector
		move_and_slide()
		if distance<50:
			velocity = Vector2(0,0)
		
		
		
	

	

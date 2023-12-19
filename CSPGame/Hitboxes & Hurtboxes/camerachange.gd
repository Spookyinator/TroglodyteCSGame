extends Area2D

var cameraA: Camera2D
var cameraB: Camera2D
var Player_previous_position: Vector2 = Vector2()
var Player
signal room_one_open
func _ready():
	cameraA = $"../Camera2D"
	cameraB = $"../Camera2D2"
	cameraA.set_process(true)
	Player = $"../Player"
	if is_instance_valid(Player):
		Player_previous_position = Player.global_position
	else:
		print("Player node not found")
	Player_previous_position = Vector2()
	pass

func _physics_process(delta):
	if is_instance_valid(Player):
			Player_previous_position = Player.global_position - Player.velocity * delta
			Player.global_position += Player.velocity * delta

func _on_body_entered(body):
	if is_instance_valid(body) and body.name == "Player":  
		room_one_open.emit()
		handle_camera_switch(body)

func handle_camera_switch(player):
	if is_instance_valid(Player):
		var Player_current_position = Player.global_position
		var movement_direction = Player_current_position - Player_previous_position
		if is_moving_towards_roomB(movement_direction):
			if not cameraB.is_current():
				cameraB.make_current()
				print(movement_direction)
		elif is_moving_towards_roomA(movement_direction):
			if not cameraA.is_current():
				cameraA.make_current()
				print(movement_direction)
func is_moving_towards_roomB(movement_direction: Vector2) -> bool:
	return movement_direction.x > 0  # Moving right

func is_moving_towards_roomA(movement_direction: Vector2) -> bool:
	return movement_direction.x < 0  # Moving left

func _on_body_exited(body):
	handle_camera_switch(body)

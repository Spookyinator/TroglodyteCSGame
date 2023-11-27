extends Node2D
#zombie scene, power up scene
@export var test_zombie_scene: PackedScene
@export var power_up_instakill_scene: PackedScene
@export var power_up_shield_scene: PackedScene
@onready var _viewport = $CanvasLayer
@onready var camera = $Camera2D
@onready var grace_timer = $GraceTimer
const POWER_UP_RATE = 0.03
var isPlayerDead = false
var gameOver = preload("res://Screens/gameOver.tscn")
var scoreLabel: Label
var waveLabel: Label
var waveAnnouncement: Label
var canSpawn = true
var waveNumber = 1
var totalZombies = 5
var player_room_location = 1
signal newWave
signal givePoints
func _ready():
	scoreLabel = get_node("CanvasLayer/ScoreLabel")
	waveLabel = get_node("CanvasLayer/WaveLabel")
	waveAnnouncement = get_node("CanvasLayer/WaveAnnouncement")
	update_score_label()
	update_wave_label()

func _physics_process(delta):
	var zombsSpawned = get_node("ZombieCounter").zombiesSpawned
	var zombsKilled = get_node("ZombieCounter").zombiesKilled
	if zombsSpawned >= totalZombies:
		canSpawn = false
	if (zombsKilled >= totalZombies):
		on_new_wave()
	if (not isPlayerDead):
		update_score_label()

func on_new_wave():
	newWave.emit()
	grace_timer.start()
	waveNumber += 1
	totalZombies = waveNumber * 5
	#print(waveNumber)
	display_new_wave()	
	update_wave_label()
	
func _on_zombie_timer_timeout():
	if (not isPlayerDead and canSpawn == true):
		var spawnArray = ["/root/Level/Spawn1","/root/Level/Spawn2","/root/Level/Spawn3","/root/Level/Spawn4"]
		var zombie = test_zombie_scene.instantiate()
		var spawnLocation = spawnArray[randi()%4]
		zombie.global_position = get_node(spawnLocation).global_position
		zombie.isKilled.connect(_on_zombie_killed)
		zombie.isHit.connect(_on_zombie_hit)
		zombie.add_to_group("Enemies")
		add_child(zombie)
func _on_zombie_hit(pointsScored):
	givePoints.emit(pointsScored)
	
func _on_zombie_killed(pointsScored, x, y):
	givePoints.emit(pointsScored)
	#update_score_label()
	if randf() < POWER_UP_RATE:
		spawn_power_up(x, y)
func spawn_power_up(x, y):
	var powerup;
	if randf() < 0.5:
		powerup = power_up_instakill_scene.instantiate()
	else:
		powerup = power_up_shield_scene.instantiate()
	powerup.global_position = Vector2(x, y)
	powerup.instakill_zombies.connect(_on_zombies_instakill)
	call_deferred("add_child",powerup)
#LABELS	

func _on_zombies_instakill():
	var zombies = get_tree().get_nodes_in_group("Enemies")
	for zombie in zombies:
		zombie._on_hitbox_no_health()
func update_score_label():
	scoreLabel.text = "Score: %d" % get_node("Player").points
func update_wave_label():
	waveLabel.text = "Wave %d" % waveNumber
func display_new_wave():
	waveAnnouncement.text = "WAVE %d INCOMING..." % waveNumber
	waveAnnouncement.visible = true
func _on_player_player_dead():
	var game_over_instance = gameOver.instantiate()
	scoreLabel.visible = false
	_viewport.add_child(game_over_instance)
	var gameMusic = get_node("GameMusic")
	if gameMusic.is_playing():
		gameMusic.stop()
	isPlayerDead = true
	var game_over = gameOver.instantiate()


func _on_grace_timer_timeout():
	canSpawn = true
	waveAnnouncement.visible = false # Replace with function body.


func _on_doorway_entered(body):
	var camera_locations = ["/root/Level/CameraLocation1","/root/Level/CameraLocation2"]
	if (player_room_location == 1):
		player_room_location = 2
	else:
		player_room_location = 1
	camera.global_position = get_node(camera_locations[player_room_location-1]).global_position
	print("Player is in room %d" % player_room_location)
	print(camera.global_position)

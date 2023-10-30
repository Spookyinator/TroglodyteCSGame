extends Node2D
#zombie scene, power up scene
@export var test_zombie_scene: PackedScene
@export var power_up_scene: PackedScene
@onready var _viewport = $CanvasLayer
#@onready var score = $CanvasLayer/ScoreLabel
@onready var grace_timer = $GraceTimer
const POWER_UP_RATE = 0.5
var isPlayerDead = false
var gameOver = preload("res://Screens/gameOver.tscn")
var points = 0
var scoreLabel: Label
var waveLabel: Label
var waveAnnouncement: Label
var canSpawn = true
var waveNumber = 1

var totalZombies = 5
signal newWave
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
		add_child(zombie)
func _on_zombie_hit(pointsScored):
	points += pointsScored
func _on_zombie_killed(pointsScored, x, y):
	points += pointsScored
	update_score_label()
	if randf() < POWER_UP_RATE:
		spawn_power_up(x, y)
func spawn_power_up(x, y):
	var powerup = power_up_scene.instantiate()
	powerup.global_position = Vector2(x, y)
	add_child(powerup)
#LABELS	
func update_score_label():
	scoreLabel.text = "Score: %d" % points
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

extends Node2D
@export var test_zombie_scene: PackedScene
var isPlayerDead = false
var gameOver = preload("res://Screens/gameOver.tscn")
var points = 0
var scoreLabel: Label

@onready var _viewport = $CanvasLayer
@onready var score = $CanvasLayer/ScoreLabel

func _ready():
	scoreLabel = get_node("CanvasLayer/ScoreLabel")
	update_score_label()
func _on_zombie_timer_timeout():
	if (not isPlayerDead):
		var spawnArray = ["/root/Level/Spawn1","/root/Level/Spawn2","/root/Level/Spawn3","/root/Level/Spawn4"]
		var zombie = test_zombie_scene.instantiate()
		var spawnLocation = spawnArray[randi()%4]
		zombie.global_position = get_node(spawnLocation).global_position
		zombie.isKilled.connect(_on_zombie_killed)
		add_child(zombie)

func _on_zombie_killed(pointsScored):
	points += pointsScored
	print(points)
	update_score_label()
func update_score_label():
	scoreLabel.text = "Score: %d" % points
func _on_player_player_dead():
	var game_over_instance = gameOver.instantiate()
	score.visible = false
	_viewport.add_child(game_over_instance)
	var gameMusic = get_node("GameMusic")
	if gameMusic.is_playing():
		gameMusic.stop()
	isPlayerDead = true
	var game_over = gameOver.instantiate()


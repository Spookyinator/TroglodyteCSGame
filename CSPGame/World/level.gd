extends Node2D
@export var test_zombie_scene: PackedScene
var isPlayerDead = false
func _on_zombie_timer_timeout():
	if (not isPlayerDead):
		var spawnArray = ["/root/Level/Spawn1","/root/Level/Spawn2","/root/Level/Spawn3","/root/Level/Spawn4"]
		var zombie = test_zombie_scene.instantiate()
		var spawnLocation = spawnArray[randi()%4]
		zombie.global_position = get_node(spawnLocation).global_position
		add_child(zombie) 


func _on_player_player_dead():
	isPlayerDead = true# Replace with function body.

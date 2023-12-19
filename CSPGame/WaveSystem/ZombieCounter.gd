extends Area2D

var zombiesSpawned = 0
var zombiesKilled = 0
var base_enemy_health = 3
var zombie = null
func _on_body_entered(body):
	zombie = body
	zombie.get_node("Hitbox").max_health = base_enemy_health
	zombiesSpawned += 1 # Replace with function body.
	print(zombie.get_node("Hitbox").max_health)

func _on_body_exited(body):
	zombiesKilled += 1 # Replace with function body

func _physics_process(delta):
	#print("ZOMBIES SPAWNED: %d" % zombiesSpawned)
	#print("ZOMBIES KILLED: %d" % zombiesKilled)
	pass

func _on_level_new_wave():
	base_enemy_health *= 1.15
	zombiesSpawned = 0
	zombiesKilled = 0

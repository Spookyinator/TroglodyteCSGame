extends Area2D

var zombiesSpawned = 0
var zombiesKilled = 0


func _on_body_entered(body):
	zombiesSpawned += 1 # Replace with function body.


func _on_body_exited(body):
	zombiesKilled += 1 # Replace with function body

func _physics_process(delta):
	#print("ZOMBIES SPAWNED: %d" % zombiesSpawned)
	#print("ZOMBIES KILLED: %d" % zombiesKilled)
	pass

func _on_level_new_wave():
	zombiesSpawned = 0
	zombiesKilled = 0

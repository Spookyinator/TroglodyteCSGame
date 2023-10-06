extends Node2D
@export var test_zombie_scene: PackedScene

func _on_zombie_timer_timeout():
	var zombie = test_zombie_scene.instantiate()
	add_child(zombie) 

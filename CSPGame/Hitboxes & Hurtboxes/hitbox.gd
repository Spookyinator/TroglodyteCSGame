extends Area2D

@export var max_health = 3.0
@export var health = 3.0

signal noHealth
func _physics_process(delta):
	if health <= 0:
		emit_signal("noHealth")

func _on_area_entered(area):
	health -= area.damage

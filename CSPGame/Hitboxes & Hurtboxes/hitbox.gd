extends Area2D

const max_health = 3.0
var health = max_health

signal noHealth
signal hit

func _physics_process(delta):
	if health < 1:
		emit_signal("noHealth")
	
func _on_area_entered(area):
	health -= area.damage
	emit_signal("hit")

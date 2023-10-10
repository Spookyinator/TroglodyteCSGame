extends Area2D

@export var health = 3

signal noHealth

func _physics_process(delta):
	if health <=0:
		emit_signal("noHealth")

func _on_area_entered(area):
	health -= area.damage

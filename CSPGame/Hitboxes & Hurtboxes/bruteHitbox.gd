extends Area2D

@export var max_health:= 5.0
var health = max_health
var isShieldActive = false
signal noHealth
signal hit

func _physics_process(delta):
	if health < 0.1:
		emit_signal("noHealth")
	
func _on_area_entered(area):
	if (not isShieldActive):
		health -= area.damage
		emit_signal("hit")


func on_shield_activated():
	isShieldActive = true


func _on_player_shield_off():
	isShieldActive = false

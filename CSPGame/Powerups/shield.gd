extends Area2D

@onready var _animated_sprite = $AnimatedSprite2D
signal instakill_zombies

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_animated_sprite.play("default")

func on_powerup_consumed():
	get_node("PlayerDetection").player.activate_shield()
	instakill_zombies.emit()
	queue_free() # Replace with function body.


func _on_despawn_timer_timeout():
	queue_free()

extends Area2D

@onready var animation_player = $AnimationPlayer
signal powerup_consumed
# Called every frame. 'delta' is the elapsed time since the previous frame.
<<<<<<< Updated upstream
func _process(delta):
	_animated_sprite.play("default")
=======
func _physics_process(delta):
	animation_player.play("Idle")
>>>>>>> Stashed changes

func on_powerup_consumed(powerup):
	get_node("PlayerDetection").player.activate_powerup(powerup)
	powerup_consumed.emit(powerup)
	queue_free() # Replace with function body.


func _on_despawn_timer_timeout():
	queue_free()
	

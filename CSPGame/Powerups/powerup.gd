extends Area2D

@onready var animation_player = $AnimationPlayer
#@onready var _animated_sprite = $AnimatedSprite2D
signal powerup_consumed
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	animation_player.play("Idle")

func on_powerup_consumed(powerup):
	get_node("PlayerDetection").player.activate_powerup(powerup)
	powerup_consumed.emit(powerup)
	queue_free()


func _on_despawn_timer_timeout():
	queue_free()
	

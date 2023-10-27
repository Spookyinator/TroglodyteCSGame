extends Area2D

@onready var _animated_sprite = $AnimatedSprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_animated_sprite.play("idle")

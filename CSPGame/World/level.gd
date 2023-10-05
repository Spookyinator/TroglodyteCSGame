extends Node2D
@export var test_zombie_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_zombie_timer_timeout():
	var zombie = test_zombie_scene.instantiate()
	add_child(zombie)

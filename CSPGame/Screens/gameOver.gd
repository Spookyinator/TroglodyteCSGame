extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_node("/root/Level/Camera2D").get_target_position() - Vector2(50,50)# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://Screens/menu.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://World/level.tscn") # Replace with function body.

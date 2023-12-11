extends Control

@onready var player = $Player

func _on_start_pressed():
	get_tree().change_scene_to_file("res://World/level.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Screens/settings.tscn")

func _physics_process(delta):
	player.look_at(get_global_mouse_position())

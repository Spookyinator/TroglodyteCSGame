extends Control

func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://Screens/menu.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://World/level.tscn") # Replace with function body.

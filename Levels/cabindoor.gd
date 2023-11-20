extends Button

func _on_button_toggled(button_pressed):
	get_tree().change_scene_to_file("res://Levels/GameWorld.tscn")

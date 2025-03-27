extends Control

var is_game_over: bool = false

func game_over() -> void:
	get_tree().paused = true
	is_game_over = true
	show()

func _on_play_again_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_home_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu.tscn")
	

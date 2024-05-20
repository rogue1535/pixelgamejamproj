extends Control

@onready var main = $"../../"
var paused = false



func _on_resume_button_down():
	main.pausemenu()


func _on_quit_button_down():
	get_tree().change_scene_to_file("res://main_menu.gd")

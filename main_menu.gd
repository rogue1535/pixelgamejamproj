extends Control

@onready var button_1 = $MarginContainer/HBoxContainer/VBoxContainer/button1
@onready var button_2 = $MarginContainer/HBoxContainer/VBoxContainer/button2
@export var start_level1 = preload("res://scenes/levels/level_1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_down():
	get_tree().change_scene_to_packed(start_level1)
	Main.cur_level = "res://scenes/levels/level_1.tscn"


func _on_exit_button_down():
	get_tree().quit()

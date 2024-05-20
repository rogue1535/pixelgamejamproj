extends Node2D

signal shark_bite
signal pickup

var mainmenu = "res://main_menu.tscn"
var level1 = "res://scenes/levels/level_1.tscn"
var level2 = "res://scenes/levels/level 2.tscn"
var cur_level = level1
var curtank = 10
var maxtank = 60
var paused = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pausemenu()


func pausemenu():
	if paused:
		self.hide()
		Engine.time_scale = 1
	else:
		self.show()
		Engine.time_scale = 0
	
	paused != paused

func restart():
	get_tree().reload_current_scene()


func golevel2():
	get_tree().change_scene_to_file(level2)
	
	cur_level = level2


func gotoend():
	
	cur_level = level1
	get_tree().change_scene_to_file(mainmenu)

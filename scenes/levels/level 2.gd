extends Node2D

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

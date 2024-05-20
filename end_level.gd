extends Node2D

var can_press = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Main.pickup.connect(on_end_level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_end_level():
	if can_press == true:
		if Main.cur_level !="res://scenes/levels/level 2.tscn":
			if can_press == true:
				Main.curtank = 10
				Main.golevel2()
		else:
			Main.gotoend()




func _on_area_2d_body_entered(body):
	if body == $"../../Player":
		can_press = true
		$"Door-sheet/Doorlayout".visible = true

func _on_area_2d_body_exited(body):
	if body == $"../../Player":
		can_press = false
		$"Door-sheet/Doorlayout".visible = false

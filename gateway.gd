extends Node2D

var can_press = false
var pressed = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Main.pickup.connect(onbuttonpress)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body == $"../../../Player":
		if pressed == false:
			can_press = true
			$"../button/Button2".frame = 1

func _on_area_2d_body_exited(body):
	if body == $"../../../Player":
		if pressed == false:
			can_press = false
			$"../button/Button2".frame = 0


func onbuttonpress():
	if can_press == true:
		$AnimationPlayer.play('open')
		$"../button/Button2".frame = 2
		pressed = true




extends Area2D

@export var pickval = 20
var pickable = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Main.pickup.connect(on_pickup)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body == $"../../Player":
		$AnimationPlayer.play('pickable')
		pickable = true


func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body == $"../../Player":
		$AnimationPlayer.play('notpickable')
		pickable = false



func on_pickup():
	if pickable == true:
		print('picked')
		
		
		if Main.curtank >= Main.maxtank:
			pass
		else:
			Main.curtank += pickval
			if Main.curtank >Main.maxtank:
				Main.curtank = Main.maxtank
				
			queue_free()

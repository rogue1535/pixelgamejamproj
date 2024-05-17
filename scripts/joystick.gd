extends Area2D

@onready var big_c = $"big circle"
@onready var smol_c = $"big circle/small circle"
@onready var max_d = $CollisionShape2D.shape.radius
var touched = false


func _input(event):
	if event is InputEventScreenTouch:
		var distance = event.position.distance_to((big_c.global_position))
		if not touched:
			touched = true
			if distance < max_d:
				smol_c.position = Vector2(0,0)
				touched = false


func _process(delta):
	if touched:
		smol_c.global_position = get_global_mouse_position()
		clamp(smol_c.position,Vector2(-max_d,-max_d),Vector2(max_d,max_d))


extends CharacterBody2D

@export var speed = 145
@export var acc = 4
@onready var nav : NavigationAgent2D =$NavigationAgent2D
@onready var player := $"../Player"
@onready var anim = $AnimationPlayer
var target 
var chase
var direction = Vector2()
var onetime = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if player:
		target = player.global_position
		if player.curstate == 2 and chase == true:
			nav.target_position = target
			direction = (nav.get_next_path_position() - global_position).normalized()
			velocity = velocity.lerp(direction * speed , acc * delta)
		else:
			velocity = velocity.lerp(Vector2(0,0),acc*delta*0.5)
	animate()
	move_and_slide()


func _on_vision_body_entered(body):
	if body ==player:
		chase = true
	
func _on_vision_body_exited(body):
	if body ==player:
		chase = false


func animate():
	rotation = lerp_angle(rotation, rotation + get_angle_to(nav.get_next_path_position()), 0.3)
	
	
	if rotation < 1.5: if rotation > -1.5:
		$Shark.flip_v = false
	
	
	if rotation >1.66: 
		$Shark.flip_v = true

	if rotation < -1.66:
		$Shark.flip_v = true

func _on_mouth_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body ==player:
		Main.emit_signal('shark_bite')
		player.velocity = global_position.direction_to(player.global_position) * 600









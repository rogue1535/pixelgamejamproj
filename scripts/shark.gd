extends CharacterBody2D

@export var speed = 150
@export var acc = 4
@onready var nav : NavigationAgent2D =$NavigationAgent2D
@onready var player = $"../Player"
@onready var anim = $AnimationPlayer
var target 
var chase
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Vector2()
	var target = player.global_position
	if player.curstate == 2 and chase == true:
		nav.target_position = target
		direction = (nav.get_next_path_position() - global_position).normalized()
	
	velocity = velocity.lerp(direction * speed , acc * delta)
	animate()
	move_and_slide()


func _on_area_2d_body_entered(body):
	print(body)
	if body ==player:
		chase = true


func animate():
	if velocity.x > 0:
		$Shark.flip_h = false
	
	if velocity.x < 0:
		$Shark.flip_h = true
	pass

extends CharacterBody2D
class_name player

@export var max_tank = 60
@export var level1 = "res://level_1.tscn"

@export var tile_size = 64
@export var speed = 5 *tile_size
@export var jump_velocity = -400.0
@export var drag = 20.0
@export var anim_curve : Curve2D 

@onready var anim = $AnimationPlayer
@onready var swim_level =  $"../Marker2D".position.y
var ground_anim = true
var is_out_water = true

var can_take_dmg = true

enum state {GROUND, MIDWAY,BELOW,BOTTOM}
var curstate = state.GROUND
var y_speed
var jump_timer = 0.0


var jump_dur = 0.5
var max_jump = -350
var min_jump = -200
var jump_press = false
var max_jumph = 4
var min_jumph = 4
var gravity = 980
var direction := Vector2.ZERO






var swim_up_velocity = -2.0 * tile_size
var passive_up_velocity = -0.3 * tile_size
var swim_down_velocity = 2.5 * tile_size
var swim_velocity = 2.0 * tile_size

func jump_calculator():
	speed = 2.5 * tile_size
	max_jumph = 1.6 * tile_size
	min_jumph = 1.1 * tile_size
	gravity = -0.8*max_jump / pow(jump_dur,2)
	max_jump = -sqrt(1* gravity * max_jumph)
	min_jump = -sqrt(1* gravity * min_jumph)
	
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	Main.maxtank = max_tank
	#Main.curtank = max_tank
	jump_calculator()
	Main.shark_bite.connect(on_shark_hit)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if Input.is_action_just_pressed('action'):
		Main.emit_signal('pickup')

	if not is_on_floor() :
		if not is_out_water:
			velocity.y += gravity*0.3 * delta
		
	animcontrol()
	
	match curstate:
		state.GROUND:
			onGround(delta)
			pass
		
		state.BELOW:
			onWater(delta)
			Main.curtank -= delta
			pass
			
		state.BOTTOM:
			pass
	
	if Main.curtank <= 0:
		restart_level()
	move_and_slide()
	pass

func onGround(delta):
	direction.x = Input.get_axis("left", "right")
	
	if direction.x:
		velocity.x = lerp(velocity.x, speed*direction.x ,0.3)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.2)
	var jmpletgo = false
	
	if is_on_floor() and not jump_press or position.y > swim_level-20:
		if Input.is_action_pressed("jump") :
			velocity.y = max_jump
			jump_press = true
	if Input.is_action_just_released("jump") :
		if velocity.y < min_jump: 
				velocity.y = min_jump
		jump_press = false
	velocity.y += gravity * delta
	if position.y > swim_level:
		curstate = state.BELOW
		

func apply_vertical_velocity(delta):
	direction.y = -float(Input.is_action_pressed('up') || Input.is_action_pressed('jump')) + int(Input.is_action_pressed('down'))
	direction.x = Input.get_axis("left", "right")
	direction = direction.normalized()
	var y_speed = passive_up_velocity
	if direction.y <0:
		y_speed = swim_up_velocity
	
	
	if direction.x:
		velocity.x = lerp(velocity.x, speed*direction.x *0.8,0.3 * delta / 0.016)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.09)
	
	
	if velocity.y < 0 and position.y <= swim_level :
			y_speed= 0.0
	
	if direction.y >0:
		y_speed = swim_down_velocity 
	
	velocity.y = lerp(velocity.y,y_speed, 0.09 * delta/0.016)# 0.075 * delta / ( 1/60))
	
	#direction.y = float(input)
	
	
	
	
	if position.y < swim_level:
		curstate = state.GROUND


func onWater(delta):
	apply_vertical_velocity(delta)



func animcontrol():
	if direction.x > 0:
		$CollisionShape2D/Diver.flip_h = false
	
	if direction.x < 0:
		$CollisionShape2D/Diver.flip_h = true
	
	if position.y < swim_level -20:
		if anim.current_animation == 'swim' or anim.current_animation == 'idleswim':
			ground_anim= true
	
	
	if position.y > swim_level:
		ground_anim = false
		if anim.current_animation == "idle" or anim.current_animation == 'run':
			
			anim.play("idleswim")
	
	
	if ground_anim == true :
		if velocity.y < 0:
			anim.play("jump")
		elif velocity.y >0:
			anim.play("downjump")
		else:
			if direction.x != 0:
				anim.play('run')
			else:
				anim.play('idle')
				
	
	
	
	
	else:
		if direction == Vector2(0,0) :
			anim.play('idleswim')
		else:
			anim.play('swim')
		
	if anim.current_animation == 'swim':
		
		
		if direction.y >0:
			if direction.x != 0:
				if $CollisionShape2D/Diver.flip_h == false:
					rotation = lerp_angle(rotation,0.7,0.4)
				else:
					rotation = lerp_angle(rotation,-0.7,0.4)
			else:
				if $CollisionShape2D/Diver.flip_h == false:
					rotation = lerp_angle(rotation,1.5,0.4)
				else:
					rotation = lerp_angle(rotation,-1.5,0.4)
			
			
		elif direction.y <0 :
			if direction.x == 0:
				if $CollisionShape2D/Diver.flip_h == false:
					rotation = lerp_angle(rotation,-1.5,0.4)
				else:
					rotation = lerp_angle(rotation,1.5,0.4)
			else:
				if $CollisionShape2D/Diver.flip_h == false:
					rotation = lerp_angle(rotation,-0.7,0.4)
				else:
					rotation = lerp_angle(rotation,0.7,0.4)
				
				
				
			
		else: 
			rotation = lerp_angle(rotation,0,0.4)
	
	else: 
		rotation = lerp_angle(rotation,0,0.4)


func on_shark_hit():
	if can_take_dmg == true:
		velocity += $"../shark".global_position.direction_to(global_position) * 600
		$"dmg timer/dmg".play('dmg')
		$"dmg timer".start()
		Main.curtank -= 10
		can_take_dmg = false

func _on_playerpiranha_body_entered(body):
	if body == self:
		$blood.emitting = true
		await get_tree().create_timer(0.9).timeout
		restart_level()


func _on_dmg_timer_timeout():
	can_take_dmg = true
	$blood.emitting = false




func restart_level():
	$"../CanvasLayer/transitions/leveltran".play('transition')
	await get_tree().create_timer(1.5).timeout
	
	
	get_tree().change_scene_to_file(Main.cur_level)
	Main.curtank = 10

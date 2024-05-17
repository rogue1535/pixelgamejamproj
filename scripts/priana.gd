extends Area2D


@onready var raycasts := [$left,$upleft,$right,$upright]
var boidsisee = []

var vel := Vector2.ZERO
var speed := 3.0
var screensize : Vector2
var mov := 33


# Called when the node enters the scene tree for the first time.
func _ready():
	#vel = Vector2(randi_range(-20,20),randi_range(-20,20))
	screensize = get_viewport_rect().size
	randomize()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	boids(delta)
	checkcollision(delta)
	vel = vel.normalized() * speed
	move()
	rotation = lerp_angle(rotation, vel.angle_to_point(Vector2.ZERO),0.4)
	

func boids(delta) :
	if boidsisee:
		var numofboids := boidsisee.size()
		var avgvel :=  Vector2.ZERO
		var avgpos :=  Vector2.ZERO
		var steeraway := Vector2.ZERO
		
		for boid in boidsisee:
			avgvel += boid.vel
			avgpos += boid.position
			#if global_position != boid.global_position:
			steeraway -= (boid.global_position - global_position) * (mov/(global_position -boid.global_position).length())
		
		avgvel /= numofboids
		vel += lerp(vel,(avgvel-vel)/2, delta)
		
		avgpos /= numofboids
		vel += (avgpos - position)
		
		steeraway /= numofboids
		vel+= steeraway

func checkcollision(delta):
	for ray in raycasts:
		var r : RayCast2D = ray
		if r.is_colliding():
			if r.get_collider().is_in_group('block'):
				var mag := 100/((r.get_collision_point() - global_position)*50).length_squared()
				vel -= lerp(vel,r.target_position.rotated(rotation) * mag,0.01)

func move() :
	global_position += vel

func _on_vision_area_entered(area):
	if area != self and area.is_in_group('boid'):
		boidsisee.append(area)

func _on_vision_area_exited(area):
	if area:
		boidsisee.erase(area)

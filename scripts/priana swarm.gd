extends Node2D

@export var num := 20
@export var margin := 100
@export var rad := 200
# Called when the node enters the scene tree for the first time.
func _ready():
	#randomize()
	#for i in num:
		#spawnboid()
	pass

func _process(delta):
	#position.y += 40*delta
	pass
	
	
func spawnboid():
	var boid = preload("res://scenes/reuseable/priana.tscn").instantiate()
	self.add_child(boid)
	#boid.modulate = Color(randf(),randf(),randf(), 1) 
	var rng = Vector2( randi_range(-rad,rad)  , randi_range(-rad,rad))
	var spawn = Vector2($".".global_position +rng)
	boid.global_position = Vector2(spawn)

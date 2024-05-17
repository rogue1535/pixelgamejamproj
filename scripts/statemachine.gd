extends Node
class_name stateMachine


@export var currentState : state
#var prev_state = null
var states : Array[state]
@onready var parent = get_parent()

func _ready():
	for child in get_children():
		if child is state:
			states.append(child)
			
		else:
			push_warning('child ' + child.name +' is not a statemachine')


func check_if_can_move():
	return currentState.can_move






func _physics_process(delta):
	if state != null:
		_state_logic(delta)
		var transition = _get_transition(delta)
		#if transition != null:
		#	set_state(prev_state, state)
		


func _state_logic(delta):
	pass
	


func _get_transition(delta):
	return null
	

func _enter_state(newState, oldState):
	pass

#func _exit_state(oldState, newState):
#	pass
	
	
#func set_state(previousState, newState):
	#prev_state = newState
	#state = newState
	#if prev_state != null:
	#	_exit_state(prev_state, newState)
	#if newState !=null:
	#	_enter_state(newState,prev_state)
	pass


func add_state(stateName):
	#states[state] = states.size()
	pass

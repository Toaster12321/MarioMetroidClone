class_name EnemyStateWander extends EnemyState

@export var wander_speed : float = 20.0 
@export var state_animation_duration : float = 0.5
@export var state_cycles_min : int = 1 #how many cycles of wander will play before transitioning to another state
@export var state_cycles_max : int = 3

var _timer : float = 0.0
var _direction : Vector2


func init() -> void:
	pass


func enter() -> void:
	enemy.animation_player.play("walk") #play walk animation
	_timer = randi_range( state_cycles_min, state_cycles_max ) * state_animation_duration #timer is based on the duration and how many cycles of the wander we want
	
	var rand = randi_range(0,1) #pick a random direction of left or right
	_direction = enemy.DIR_2[ rand ]
	enemy.velocity = _direction * wander_speed #set velocity
	enemy.set_direction( _direction ) #set left or right direction
	pass


func exit() -> void:
	pass


func process( _delta : float ) -> EnemyState:
	_timer -= _delta #start timer
	if _timer <= 0:
		return idle #return to idle after wandering
	
	return null


func physics_process( _delta : float ) -> EnemyState:
	return null

class_name EnemyStateIdle extends EnemyState

@export var state_duration_min : float = 0.5
@export var state_duration_max : float = 1.5

var _timer : float = 0.0

func init() -> void:
	pass


func enter() -> void:
	enemy.animation_player.play("idle")
	_timer = randf_range( state_duration_min, state_duration_max )
	enemy.velocity = Vector2.ZERO
	pass


func exit() -> void:
	pass


func process( _delta : float ) -> EnemyState:
	_timer -= _delta
	if _timer <= 0:
		return wander
	return null


func physics_process( _delta : float ) -> EnemyState:
	return null

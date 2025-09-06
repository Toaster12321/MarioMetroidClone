class_name KnightStateDeath extends KnightState

var deceleration : float = 10.0

func init() -> void:
	pass


func enter() -> void:
	knight.animation_player.play("death")
	pass


func exit() -> void:
	pass


func handle_input( _event : InputEvent ) -> KnightState:
	return null


func process( _delta : float ) -> KnightState:
	knight.update_velocity(0, deceleration)
	return null


func physics_process( _delta : float ) -> KnightState:
	return null

class_name KnightStateIdle extends KnightState

@export var deceleration : float = 8


func init() -> void:
	pass


func enter() -> void:
	knight.animation_player.play("idle" + knight.update_direction(direction.x)) #play animation
	pass


func exit() -> void:
	pass


func handle_input( _event : InputEvent ) -> KnightState:
	if _event.is_action_pressed("jump"): #transition to jump state when button is pressed
		return jump
	return null


func process( _delta : float ) -> KnightState:
	
	if direction.x != 0: #if the player is holding any direction in the x axis we are running
		return run
		
	return null


func physics_process( _delta : float ) -> KnightState:
	
	
	knight.update_velocity( 0, deceleration ) #stop players velocity and acceleration
	if not knight.is_on_floor(): # if we are in the air go to fall state
		return fall
	return null

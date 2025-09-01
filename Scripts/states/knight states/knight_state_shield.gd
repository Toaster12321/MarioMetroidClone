class_name KnightStateShield extends KnightState

@export var deceleration : float = 8

var shielding : bool =  false

func init() -> void:
	pass


func enter() -> void:
	knight.animation_player.play("shield") #play shielding animation
	shielding = true # we are shielding
	pass


func exit() -> void:
	shielding = false #we arent shielding
	pass


func handle_input( _event : InputEvent ) -> KnightState:
	if _event.is_action_pressed("shield"): #transition to attack state when button is pressed
		shielding = true #if we hold shield button keep shielding
		return self
	elif _event.is_action_released("shield"):
		shielding = false #when released we are no longer shielding
	elif _event.is_action_pressed("jump"): #transition to jump state when button is pressed
		return jump
	elif _event.is_action_pressed("attack"): #transition to attack state when button is pressed
		return attack
	return null


func process( _delta : float ) -> KnightState:
	return null


func physics_process( _delta : float ) -> KnightState:
	knight.update_velocity( 0, deceleration ) #slow player when they start to shield
	if direction.x != 0 and shielding != true: #if the player is holding any direction in the x axis we are running and we arent shielding
		return run
	elif direction.y > 0 and shielding != true: #pressing the down key 
		return crouch
	elif not knight.is_on_floor(): # if we are in the air go to fall state
		return fall
	return null

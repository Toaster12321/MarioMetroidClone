class_name KnightStateAttack extends KnightState

var attacking : bool = false

@export var deceleration : float = 4

func ready() -> void:
	pass


func init() -> void:
	pass


func enter() -> void:
	knight.animation_player.play("attack")
	knight.animation_player.animation_finished.connect( end_attack ) #signal to show when the attack has finished
	
	attacking = true
	await get_tree().create_timer( 0.075 ).timeout #creates slight delay before hitting
	if attacking:
		pass #implement hurtbox and turn on
	pass


func exit() -> void:
	attacking = false
	knight.animation_player.animation_finished.disconnect( end_attack ) #disconnect the signal
	#turn off hurtbox
	pass


func handle_input( _event : InputEvent ) -> KnightState:
	if _event.is_action_pressed("attack"):
		knight.animation_player.play("attack_2")
	return null


func process( _delta : float ) -> KnightState:
	return null


func physics_process( _delta : float ) -> KnightState:
	knight.update_velocity( 0 , deceleration ) #slows player down by deceleration value to a stop
	
	if attacking == false: #when attacking has finished
		if direction.x == 0: #not moving 
			return idle
		elif not knight.is_on_floor(): #if not on floor go to fall state
			return fall
		else:# if not idle then we are moving
			return run 
	
	return null


func end_attack(_anim_name: StringName) -> void: #animation name parameter avoids method expected error
	attacking = false #show that animation has finished and we are not attacking anymore
	pass

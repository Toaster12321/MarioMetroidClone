class_name KnightStateHit extends KnightState

@export var knockback_speed : float = 200.0 #knockback speed when hit
@export var decelerate_speed : float = 10.0 #how fast velocity slows
@export var invulnerable_duration : float = 1.0 #invincible for 1s by default

var hurtbox : Hurtbox
var _direction : Vector2
var _normalized_direction : Vector2
var _anim_finished : bool = false


func init() -> void:
	knight.player_damaged.connect( _player_damaged ) #connect function for when player is damaged
	pass


func enter() -> void:
	_anim_finished = false #animation not finished
	knight.animation_player.animation_finished.connect( _animation_finished ) #connect function for when animation is finished
	
	_direction = knight.global_position.direction_to( hurtbox.global_position ) #get the direction towards the hurtbox from the knight
	knight.velocity = _direction * -knockback_speed #knight knockback speed
	
	if _direction.x > 0: #normalize direction into left and right instead of floats
		_normalized_direction = Vector2.RIGHT
	else:
		_normalized_direction = Vector2.LEFT
	knight.update_direction( _normalized_direction.x ) #update knight's facing direction
	
	knight.animation_player.play("hit") #play hit + damaged animations and start i-frames
	knight.make_invulnerable( invulnerable_duration )
	knight.effect_animation_player.play("damaged")
	
	#camera shake?
	pass


func exit() -> void:
	knight.animation_player.animation_finished.disconnect( _animation_finished ) #disconnect function
	pass


func handle_input( _event : InputEvent ) -> KnightState:
	return null


func process( _delta : float ) -> KnightState:
	knight.velocity -= knight.velocity * decelerate_speed * _delta #decrease player velocity 
	
	if _anim_finished != false: #if the animation has finished return eitehr fall or idle
		if knight.is_on_floor() == false:
			return fall
		else:
			return idle
	return null


func physics_process( _delta : float ) -> KnightState:
	return null


func _player_damaged( _hurtbox : Hurtbox ) -> void:
	hurtbox = _hurtbox #send hurtbox to player damaged signal
	if knight.hp <= 0:
		state_machine.change_state( death )
	else:
		state_machine.change_state( self ) #change state to hurt
	pass


func _animation_finished( _anim : String ) -> void:
	if knight.hp <= 0:
		state_machine.change_state( death )
	_anim_finished = true

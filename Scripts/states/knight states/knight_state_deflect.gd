class_name KnightStateDeflect extends KnightState

@onready var hitbox: Hitbox = $"../../Hitbox"
@onready var shieldbox: Shieldbox = $"../../ShieldHitbox"

var _anim_finished : bool = false
var _next_state : KnightState
var _shield_held : bool = false

func init() -> void:
	pass


func enter() -> void:
	_anim_finished = false #animation hasnt finished
	knight.animation_player.animation_finished.connect( _on_anim_finished ) #connect to when deflect anim finishes
	
	knight.animation_player.play("shield_deflect")
	pass


func exit() -> void:
	_anim_finished = false #reset anim finished
	knight.animation_player.animation_finished.disconnect( _on_anim_finished ) #disconnect signal

	pass


func handle_input( _event : InputEvent ) -> KnightState:
	if _anim_finished == true: #if the animation has finished allow for inputs
		if _event.is_action_pressed("jump") : #transition to jump state when button is pressed
			return jump
		elif _event.is_action_pressed("attack"): #transition to attack state when button is pressed
			return attack
		elif _event.is_action_pressed("crouch"):
			return crouch
	return null


func process( _delta : float ) -> KnightState:
	knight.velocity = Vector2.ZERO #make player stand still when hit
	
	_shield_held = Input.is_action_pressed("shield") #check every frame for shielding 
	
	if _anim_finished == true: #if animation is over
		if _shield_held: #if shield was held the whole time continue to shield
			return _next_state
		else:
			return idle #leave state
	return null


func physics_process( _delta : float ) -> KnightState:
	return null


func _on_anim_finished( _anim : String ) -> void:
	_anim_finished = true #animation has finished
	_next_state = shield
	pass

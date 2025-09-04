class_name KnightStateShield extends KnightState

@export var shielding_speed : float = 40.0 #movement for walking while shielding
@export var deceleration : float = 5.0

@onready var hitbox: Hitbox = $"../../Hitbox"
@onready var shieldbox: Shieldbox = $"../../ShieldHitbox"

var hurtbox : Hurtbox


var shielding : bool =  false
var hitbox_monitor : bool = true
var shieldbox_monitor : bool = false


func init() -> void:
	knight.damage_blocked.connect( _damage_blocked ) #connect damage blocked signal from knight class
	pass


func enter() -> void:
	shielding = true # we are shielding
	hitbox_monitor = false #turn off normal hitbox
	shieldbox_monitor = true #turn on shield hitbox
	
	if direction.x == 0: #if we arent moving play idle shield animation otherwise play walking animation
		knight.animation_player.play("shield")
	else:
		knight.animation_player.play("shield_walk_forward")
	pass


func exit() -> void:
	shielding = false #we arent shielding
	hitbox_monitor = true #turn on normal hitbox
	shieldbox_monitor = false #turn off shield hitbox
	pass 


func handle_input( _event : InputEvent ) -> KnightState:
	if _event.is_action_pressed("shield"): #transition to attack state when button is pressed
		shielding = true #if we hold shield button keep shielding
		return self
	elif _event.is_action_released("shield"):
		shielding = false
		return idle #when released we are no longer shielding
	elif _event.is_action_pressed("jump"): #transition to jump state when button is pressed
		return jump
	elif _event.is_action_pressed("attack"): #transition to attack state when button is pressed
		return attack
	return null


func process( _delta : float ) -> KnightState:
	knight.update_velocity( direction.x * shielding_speed, deceleration ) #slow player down to shield walk speed
	
	if direction.x == 0: #play shield idle if not moving
		knight.animation_player.play("shield")
	else: #other wise play forward animation if our directions match each other
		if sign(direction.x) == sign(knight.current_direction):
			knight.animation_player.play("shield_walk_forward")
		else:
			knight.animation_player.play("shield_walk_back")
	return null


func physics_process( _delta : float ) -> KnightState:
	if knight.velocity.x != 0 and shielding != true: #if the player is holding any direction in the x axis we are running and we arent shielding
		return run
	elif direction.y > 0 and shielding != true: #pressing the down key 
		return crouch
	elif not knight.is_on_floor(): # if we are in the air go to fall state
		return fall
	
	hitbox.monitorable = hitbox_monitor #check every frame for monitoring to avoid set deferred error
	shieldbox.monitorable = shieldbox_monitor
	return null


func _damage_blocked( _hurtbox : Hurtbox ) -> void:
	hurtbox = _hurtbox #get passed hurtbox
	print("player blocked")
	state_machine.change_state( death ) #block damage
	pass

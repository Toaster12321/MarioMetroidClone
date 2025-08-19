class_name KnightStateCrouch extends KnightState

@export var deceleration : float = 5
@onready var collision_shape_2d: CollisionShape2D = $"../../CollisionShape2D" #collision shapes for normal + crouch sprites
@onready var collision_shape_2d_crouch: CollisionShape2D = $"../../CollisionShape2D_Crouch" 
@onready var ray_cast_2d: RayCast2D = $RayCast2D


func ready() -> void:
	pass


func init() -> void:
	ray_cast_2d.enabled = false
	pass


func enter() -> void:
	knight.animation_player.play("crouch")
	ray_cast_2d.enabled = true #enable raycast
	collision_shape_2d.disabled = true #disable normal collision shape
	collision_shape_2d_crouch.disabled = false #enable crouch collision shape
	pass


func exit() -> void: #disable crouch collision and revert to normal collision
	collision_shape_2d.disabled = false #re-enable normal collision shape
	collision_shape_2d_crouch.disabled = true #disable crouch collision shape
	ray_cast_2d.enabled = false #disable raycast
	pass


func handle_input( _event : InputEvent ) -> KnightState:
	if _event.is_action_pressed("jump"):
		if ray_cast_2d.is_colliding() == true:
			knight.position.y += 2
			return fall
		return jump
	return null


func process( _delta : float ) -> KnightState:
	return null


func physics_process( _delta : float ) -> KnightState:
	knight.update_velocity( 0 , deceleration ) #slows player down by deceleration value to a stop
	if direction.y <= 0: #we arent pressing the down key
		return idle
	elif not knight.is_on_floor(): #if not on floor go to fall state
		return fall
	return null

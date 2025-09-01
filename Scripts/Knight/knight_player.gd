class_name Knight extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var camera_2d: Camera2D = $Camera2D
@onready var idle: KnightStateIdle = %Idle
@onready var run: KnightStateRun = %Run
@onready var jump: KnightStateJump = %Jump
@onready var fall: KnightStateFall = %Fall
@onready var crouch: KnightStateCrouch = %Crouch
@onready var knight_state_machine: KnightStateMachine = $KnightStateMachine
@onready var shield: KnightStateShield = %Shield
@onready var attack: KnightStateAttack = %Attack
@onready var sprites: Node2D = $Sprites
@onready var hitbox: Hitbox = $Hitbox


var gravity : float = 980 #9.81m/s gravity speed
var gravity_multiplier : float = 1
var current_direction : float
var default_cam_position : float

signal player_damaged( hurtbox : Hurtbox )
var invulnerable = false
var hp : int = 6
var max_hp : int = 6

func _ready() -> void:
	knight_state_machine.init(self) #inistialize state machine to player
	default_cam_position = camera_2d.position.y #get default camera y placement
	hitbox.damaged.connect( _take_damage ) #take damage if hitbox has been entered
	update_hp(99) #restore player to full hp
	pass


func _physics_process(delta: float) -> void:
	if is_on_floor() == false: #if not on floor
		velocity.y += gravity * delta * gravity_multiplier #applying gravity in the y axis
	move_and_slide() # allows movement


func _process(_delta: float) -> void:
	pass


func update_velocity( _velocity : float, _acceleration : float ) -> void:
	velocity.x = move_toward( velocity.x, _velocity, _acceleration ) #updates velocity in the x axis from base velocity to max velocity passed in at a delta value of acceleration
	pass


func play_audio( audio : AudioStream ) -> void: #function to play audio streams
	if audio == null:
		return
	
	audio_stream_player_2d.stream = audio
	audio.play()
	pass


func update_direction( direction : float ) -> void: #when we change from left to right or vice versa update animation name to respective direction
	if direction != 0: #if we arent not standing still set the current direction to passed in direction
		current_direction = direction
	
	if current_direction < 0: #if our direction is -1 we are going left otherwise right
		sprites.scale.x = -1 #flip left
	else:
		sprites.scale.x = 1 #flip right
	pass


func update_animation( state : String ) -> void: #function that takes a state and updates its animation if it needs multiple directions
	animation_player.play(state + "_" + anim_direction())


func anim_direction() -> String: #returns a left or right based on the current direction of the player
	if current_direction < 0:
		return "left"
	else:
		return "right"


func _take_damage( hurtbox : Hurtbox ) -> void: #take damage function for player
	if invulnerable == true: #do nothing if we have been hit already
		return 
	 
	if hp > 0: #if we have hp decrease it
		update_hp( -hurtbox.damage )
		print(hp)
		player_damaged.emit( hurtbox ) #trigger the player damaged signal with hurtbox passed in
	pass


func update_hp( _delta : int ) -> void: #increases or decreases knights hp
	hp = clampi( hp + _delta, 0, max_hp ) #clamp to make sure hp stays between 0 and max
	pass


func make_invulnerable( _duration : float ) -> void: #make knight invulnerable shortly
	invulnerable = true 
	hitbox.monitoring = false # turn off hitbox for a duration
	
	await get_tree().create_timer( _duration ).timeout #after duration ends we can be hit again
	invulnerable = false
	hitbox.monitoring = true
	pass

class_name Knight extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var idle: KnightStateIdle = %Idle
@onready var run: KnightStateRun = %Run
@onready var jump: KnightStateJump = %Jump
@onready var fall: KnightStateFall = %Fall
@onready var crouch: KnightStateCrouch = %Crouch
@onready var knight_state_machine: KnightStateMachine = $KnightStateMachine


var gravity : float = 980 #9.81m/s gravity speed
var gravity_multiplier : float = 1
var current_direction : float

func _ready() -> void:
	knight_state_machine.init(self) #initialize state machine to player
	pass


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta * gravity_multiplier #applying gravity in the y axis
	move_and_slide() # allows movement


func _process(delta: float) -> void:
	pass


func update_velocity( _velocity : float, _acceleration : float ) -> void:
	velocity.x = move_toward( velocity.x, _velocity, _acceleration ) #updates velocity in the x axis from base velocity to max velocity passed in at a delta value of acceleration
	pass


func play_audio( audio : AudioStream ) -> void:
	if audio == null:
		return
	
	audio_stream_player_2d.stream = audio
	audio.play()
	pass


func update_direction( direction : float ) -> String: #when we change from left to right or vice versa update animation name to respective direction
	if direction != 0: #if we are moving update direction
		current_direction = direction
		
	if current_direction < 0: #if are direction is -1 we are going left otherwise right
		return "_left"
	else:
		return ""
	pass

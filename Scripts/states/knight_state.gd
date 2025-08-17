class_name KnightState extends Node2D
#state template

static var knight : Knight
static var state_machine : KnightStateMachine
static var direction : Vector2

@onready var idle: KnightStateIdle = %Idle
@onready var run: KnightStateRun = %Run
@onready var jump: KnightStateJump = %Jump
@onready var fall: KnightStateFall = %Fall
@onready var crouch: KnightStateCrouch = %Crouch



func ready() -> void:
	pass


func init() -> void:
	pass


func enter() -> void:
	pass


func exit() -> void:
	pass


func handle_input( _event : InputEvent ) -> KnightState:
	return null


func process( _delta : float ) -> KnightState:
	return null


func physics_process( _delta : float ) -> KnightState:
	return null

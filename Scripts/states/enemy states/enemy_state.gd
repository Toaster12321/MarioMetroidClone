class_name EnemyState extends Node2D
#state template


static var enemy : Enemy
static var state_machine : EnemyStateMachine
static var direction : Vector2

@onready var idle: EnemyStateIdle = %Idle
@onready var wander: EnemyStateWander = %Wander
@onready var hurt: EnemyStateHurt = %Hurt
@onready var death: EnemyStateDeath = %Death
@onready var attack: EnemyStateAttack = %Attack


func ready() -> void:
	pass


func init() -> void:
	pass


func enter() -> void:
	pass


func exit() -> void:
	pass


func process( _delta : float ) -> EnemyState:
	return null


func physics_process( _delta : float ) -> EnemyState:
	return null

class_name Enemy extends CharacterBody2D

signal direction_changed( new_direction : Vector2 )
signal enemy_damaged( hurt_box : Hurtbox )
signal enemy_destroyed( hurt_box : Hurtbox )

var gravity : float = 980 #9.81m/s gravity speed
var gravity_multiplier : float = 1
var direction : Vector2 = Vector2.ZERO

const DIR_2 = [ Vector2.LEFT, Vector2.RIGHT ] 

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var wander: EnemyStateWander = %Wander
@onready var hurt: EnemyStateHurt = %Hurt
@onready var death: EnemyStateDeath = %Death
@onready var attack: EnemyStateAttack = %Attack
@onready var enemy_state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var sprite: Node2D = $Sprite



func _ready() -> void:
	enemy_state_machine.init( self )
	pass


func _physics_process(delta: float) -> void:
	if is_on_floor() == false: #if not on floor
		velocity.y += gravity * delta * gravity_multiplier #applying gravity in the y axis
	move_and_slide() # allows movement
	pass


func set_direction( _new_direction : Vector2 ) -> void:
	if _new_direction != Vector2.ZERO:
		direction = _new_direction
	
		if _new_direction == Vector2.LEFT: #since sprite starts left side we flip logic
			sprite.scale.x = 1   #if we are facing left flip to right
		elif _new_direction == Vector2.RIGHT: 
			sprite.scale.x = -1 #if we are facing right flip to left
	
	direction_changed.emit( direction )

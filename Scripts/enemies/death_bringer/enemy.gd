class_name Enemy extends CharacterBody2D

var gravity : float = 980 #9.81m/s gravity speed
var gravity_multiplier : float = 1

func _ready() -> void:
	
	pass


func _physics_process(delta: float) -> void:
	if is_on_floor() == false: #if not on floor
		velocity.y += gravity * delta * gravity_multiplier #applying gravity in the y axis
	
	move_and_slide() # allows movement
	pass

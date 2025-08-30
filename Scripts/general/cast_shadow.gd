class_name ClassShadow extends Node2D

@export var shadow_size : Vector2

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var point_light_2d: PointLight2D = $PointLight2D

var ray_y_collision_point : float = 0.0

func _ready() -> void:
	point_light_2d.scale = shadow_size
	pass

func _physics_process( _delta : float) -> void:
	if ray_cast_2d.is_colliding():
		ray_y_collision_point = ray_cast_2d.get_collision_point().y #detect y coord of the ground below raycast
	else:
		ray_y_collision_point = ray_cast_2d.global_position.y + ray_cast_2d.target_position.y #places collision point at the furthest end of the raycast
	
	point_light_2d.global_position.y = ray_y_collision_point #update shadow position with y coord
	point_light_2d.energy = max( 1.0 - point_light_2d.position.y / ray_cast_2d.target_position.y, 0.0 )#gives us a number between 0 and 1 to change alpha value pf shadow based on how far we are from the ground
	pass

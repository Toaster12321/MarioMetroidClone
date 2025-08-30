class_name VisionArea extends Area2D

signal player_enetered()
signal player_exited()

func _ready() -> void:
	body_entered.connect( _on_body_entered )
	body_exited.connect( _on_body_exited )
	
	var parent = get_parent()
	if parent is Enemy:
		parent.direction_changed.connect( _on_direction_changed )


func _on_body_entered( _body : Node2D ) -> void:
	if _body is Knight:
		player_enetered.emit()
	pass


func _on_body_exited( _body : Node2D ) -> void:
	if _body is Knight:
		player_exited.emit()
	pass


func _on_direction_changed( new_direction : Vector2 ) -> void:
	match new_direction:
		Vector2.LEFT:
			rotation_degrees = 90
		Vector2.RIGHT:
			rotation_degrees = -90
		_:
			rotation_degrees = 0
	pass

class_name VisionArea extends Area2D

signal player_enetered()
signal player_exited()

func _ready() -> void:
	body_entered.connect( _on_body_entered ) #connect function for player entering body
	body_exited.connect( _on_body_exited ) #connect function for player exiting body
	
	var parent = get_parent()
	if parent is Enemy: # if the area is attached to an Enemy type make sure to update direction of area with enemy
		parent.direction_changed.connect( _on_direction_changed )


func _on_body_entered( _body : Node2D ) -> void:
	if _body is Knight: #if the body entered was a knight trigger the player entered signal
		player_enetered.emit()
	pass


func _on_body_exited( _body : Node2D ) -> void:
	if _body is Knight:  #if the body exited was a knight trigger the player exited signal
		player_exited.emit()
	pass


func _on_direction_changed( new_direction : Vector2 ) -> void:
	match new_direction: #flip vision area 180 degrees if we are facing right otherwise default facing left
		Vector2.LEFT:
			rotation_degrees = 0
		Vector2.RIGHT:
			rotation_degrees = 180
		_:
			rotation_degrees = 0
	pass

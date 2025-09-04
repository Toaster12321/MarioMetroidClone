class_name Shieldbox extends Area2D 

#signal that emits when hitbox has connected with another area2D or damaged
signal deflected( hurt_box : Hurtbox )

func shield_damage( hurt_box : Hurtbox ) -> void: #function to shield damage based off passed hurtbox scene
	deflected.emit( hurt_box )

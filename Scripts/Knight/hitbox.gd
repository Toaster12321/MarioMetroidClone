class_name Hitbox extends Area2D 

signal damaged( hurt_box : Hurtbox )  #signal that emits when hitbox has connected with another area2D or damaged

func take_damage( hurt_box : Hurtbox ) -> void: #function to take damage based off damage listed in passed hurtbox scene
	damaged.emit( hurt_box )

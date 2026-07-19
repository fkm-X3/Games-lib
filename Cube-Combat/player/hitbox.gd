class_name Hitbox
extends Area2D

@export var damage: int = 10

func _on_area_entered(area: Area2D) -> void:
	# Safe check to see if the entered area is a Hurtbox
	if area is Hurtbox:
		area.take_damage(damage)

class_name Hurtbox
extends Area2D

# Reference the main script managing health (e.g., CharacterBody2D)
@onready var parent = get_parent() 

func take_damage(amount: int):
	if parent.has_method("reduce_health"):
		parent.reduce_health(amount)
		print("health reduced")

func reduce_health(amount: int) -> void:
	print("Ouch! Took ", amount, " damage!")

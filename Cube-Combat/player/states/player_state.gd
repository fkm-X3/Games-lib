class_name PlayerState
extends Node

var player: CharacterBody2D

# Called when the state machine enters this state
func enter() -> void:
	pass

# Called when the state machine exits this state
func exit() -> void:
	pass

# Replaces the main _process logic for this state
func handle_input(event: InputEvent) -> void:
	pass

# Replaces the main _physics_process logic for this state
func update_physics(delta: float) -> void:
	pass

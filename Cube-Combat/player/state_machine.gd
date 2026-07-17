# res://player/state_machine.gd
class_name StateMachine
extends Node

@export var initial_state: PlayerState

var current_state: PlayerState
var states: Dictionary = {}

func init(player: CharacterBody2D) -> void:
	for child in get_children():
		if child is PlayerState:
			states[child.name.to_lower()] = child
			child.player = player
	
	if initial_state:
		change_to(initial_state.name.to_lower())

func change_to(state_name: String) -> void:
	var target_state = states.get(state_name.to_lower())
	if not target_state:
		return
		
	if current_state:
		current_state.exit()
		
	current_state = target_state
	current_state.enter()

func handle_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func update_physics(delta: float) -> void:
	if current_state:
		current_state.update_physics(delta)

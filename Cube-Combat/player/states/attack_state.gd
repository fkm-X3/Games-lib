# res://player/states/attack_state.gd
class_name AttackState
extends PlayerState

@onready var state_machine: StateMachine = get_parent()

func enter() -> void:
	# Trigger the attack presentation logic
	print("Performing Attack!")
	# $AnimationPlayer.play("attack")
	
	# Temporary timer logic from your original script
	await get_tree().create_timer(0.4).timeout
	_on_attack_finished()

func update_physics(delta: float) -> void:
	# Stop horizontal momentum instantly if attacking on the ground
	if player.is_on_floor():
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)

func _on_attack_finished() -> void:
	# Only transition back if we are still in this state
	if state_machine.current_state == self:
		state_machine.change_to("MoveState")

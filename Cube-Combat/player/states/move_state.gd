class_name MoveState
extends PlayerState

@onready var state_machine: StateMachine = get_parent()

func update_physics(delta: float) -> void:
	# Jump
	if Input.is_action_just_pressed("move_jump") and player.is_on_floor():
		player.velocity.y = player.jump_velocity

	# Horizontal Movement
	var direction := Input.get_axis("move_left", "move_right")
	if direction != 0:
		player.velocity.x = direction * player.speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)
	
	# Transition to Attack State
	if Input.is_action_just_pressed("attack_1"):
		state_machine.change_to("AttackState")
		# Optional: pass an argument or set a variable on the attack state for light attack
	elif Input.is_action_just_pressed("attack_2"):
		state_machine.change_to("AttackState")

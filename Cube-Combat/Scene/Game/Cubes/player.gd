extends CharacterBody2D

@export var speed: float = 300.0
@export var jump_velocity: float = -600.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

# Track if the player is currently locked in an attack animation
var is_attacking: bool = false

func _process(delta):
	if Input.is_action_just_pressed("quit_match"):
		get_tree().change_scene_to_file("res://main_menu.tscn")

func _physics_process(delta: float) -> void:
	# Apply Gravity (still applies while attacking so you can fall/jump-attack)
	if not is_on_floor():
		velocity.y += gravity * delta

	# Check for Attacks
	# Only allow attacking if you aren't already in the middle of an attack
	if not is_attacking:
		if Input.is_action_just_pressed("attack_1"):
			start_attack("attack_1")
		elif Input.is_action_just_pressed("attack_2"):
			start_attack("attack_2")

	# Handle Jump & Movement
	# Lock these out if the player is currently attacking
	if not is_attacking:
		if Input.is_action_just_pressed("move_jump") and is_on_floor():
			velocity.y = jump_velocity

		var direction := Input.get_axis("move_left", "move_right")
		if direction != 0:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
	else:
		# Stop horizontal momentum instantly when attacking on the ground
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

# Triggers the attack logic
func start_attack(attack_type: String) -> void:
	is_attacking = true
	
	if attack_type == "attack_1":
		print("Performing Light Attack!")
		# If using an AnimationPlayer, you would call: $AnimationPlayer.play("light_attack")
	elif attack_type == "attack_2":
		print("Performing Heavy Attack!")
		# If using an AnimationPlayer, you would call: $AnimationPlayer.play("heavy_attack")
	
	# TEMPORARY: Right now, we use a quick timer to reset the attack state.
	# Eventually you will hook this up to the AnimationPlayer's "animation_finished" signal.
	await get_tree().create_timer(0.4).timeout
	_on_attack_finished()
	
func _on_attack_finished() -> void:
	is_attacking = false

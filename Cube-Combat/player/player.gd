extends CharacterBody2D

@export var speed: float = 300.0
@export var jump_velocity: float = -600.0

@onready var state_machine: StateMachine = $StateMachine

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	state_machine.init(self)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit_match"):
		get_tree().change_scene_to_file("res://main_menu.tscn")

func _unhandled_input(event: InputEvent) -> void:
	state_machine.handle_input(event)

func _physics_process(delta: float) -> void:
	# Apply Gravity globally (applies across all states)
	if not is_on_floor():
		velocity.y += gravity * delta

	# Delegate state-specific physics to the state machine
	state_machine.update_physics(delta)
	
	move_and_slide()

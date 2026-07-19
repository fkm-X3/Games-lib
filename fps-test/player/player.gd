extends CharacterBody3D

@onready var camera = $Head/Camera3D
@onready var head = $Head

# Unchangable var's
const MOUSE_SENSITIVITY = 0.2
const GRAVITY = 10
const JUMP_SPEED = 4
const SPEED = 5.5
const ACCEL = 8.0

var currentvel = Vector3.ZERO # Empty dimentional pos
var velocity_y = 0

# var's for head bobbing
const BOB_FREQ = 1.8
const BOB_AMP = 0.05
var bob_speed = 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # Hide mouse once in game

func _physics_process(delta: float) -> void:
	# input1 - input2 = dir_x (eg: pressing right "1 - 0 = 1")
	var dir_x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var dir_z = Input.get_action_strength("back") - Input.get_action_strength("forward")
	var input_dir = Vector2(dir_x, dir_z).normalized() # Normalize the 2d dirs so moving diagonal isn't faster then moving straight
	
	# Calculate velocity
	var target_velocity = (global_transform.basis.x * input_dir.x + global_transform.basis.z * input_dir.y) * SPEED
	
	# Don't just move, accelerate a little 
	currentvel = currentvel.lerp(target_velocity, ACCEL * delta)
	velocity.x = currentvel.x
	velocity.y = currentvel.y
	velocity.z = currentvel.z
	
	# Jumping
	if is_on_floor(): # If not on the floor, don't check for jump
		if Input.is_action_just_pressed("jump"): # If spacebar is pressed then jump
			velocity_y = JUMP_SPEED
		else:
			velocity_y = 0
	else: # Apply gravity 
		velocity_y -= GRAVITY * delta
	
	velocity.y = velocity_y # Internal velocity = to var
	move_and_slide()

# Move the camera
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion: # If mouse moving
		head.rotate_x(deg_to_rad(event.relative.y * -MOUSE_SENSITIVITY))
		head.rotation_degrees.x = clamp(head.rotation_degrees.x, -90, 60) # Player can't look up or down past this
		self.rotate_y(deg_to_rad(event.relative.x * -MOUSE_SENSITIVITY))

func _process(delta: float) -> void:
	bob_speed += delta * velocity.length() * float(is_on_floor())
	camera.position = headbob(bob_speed)

func headbob(speed) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(speed * BOB_FREQ) * BOB_AMP # Decide how far up and how long it takes to come back down
	pos.x = cos(speed * BOB_FREQ / 2) * BOB_AMP # Same as Y but not as much 
	return pos

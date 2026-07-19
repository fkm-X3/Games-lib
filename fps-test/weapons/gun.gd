extends Node3D

@export var damage = 1.0 # Can change in inspector

@onready var anim: AnimationPlayer = $anim
@onready var shot_sound = $shot_sound
@onready var raycast = $RayCast

var can_shoot = false

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and can_shoot and not anim.is_playing():
		anim.play("shoot")
		shot_sound.play()
		can_shoot = false
		if raycast.is_colliding():
			if raycast.get_collider().is_in_group("ennemy"):
				raycast.get_collider().hp -= damage

func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "shoot":
		can_shoot = true
	elif anim_name == "equip":
		can_shoot = true
	elif anim_name == "unequip":
		can_shoot = false
		visible = false

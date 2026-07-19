extends Node3D

var weapons = [] # List of weapons
var selected_weapon = 0 # Index of weapons

func _ready() -> void:
	for w in self.get_children():
		weapons.append(w) # Attached W to each weapon
		w.visible = false
		w.anim.play("unequip")
	weapons[selected_weapon].visible = true
	weapons[selected_weapon].anim.play("equip")

func _process(delta):
	if Input.is_action_just_pressed("next_weapon"): # If next weapon pressed add 1
		weapon_change(1)
	elif Input.is_action_just_pressed("previous_weapon"): # If previous weapon pressed remove 1
		weapon_change(-1)

func weapon_change(direction):
	weapons[selected_weapon].anim.play("unequip")
	selected_weapon += direction
	# If negitive then loop back around
	if (selected_weapon < 0):
		selected_weapon += weapons.size()
	elif selected_weapon >= weapons.size():
		selected_weapon -= weapons.size()
	
	weapons[selected_weapon].visible = true
	weapons[selected_weapon].anim.play("equip")

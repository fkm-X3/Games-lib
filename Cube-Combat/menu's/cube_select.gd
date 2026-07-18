extends Node

# Initalizing variables
var cube_selected = 0
var cube_stat_HP = 0
var cube_stat_attack1 = "placeholder"
var cube_stat_attack2 = "placeholder"

# Where the ColorReact and Lable are
@onready var lable: Label = $Lable
@onready var color_rect: ColorRect = $ColorRect

func _on_sword_master_pressed() -> void:
	# Setting variables for Sword master
	cube_selected = 1
	cube_stat_HP = 100
	cube_stat_attack1 = "Slash"
	cube_stat_attack2 = "Parry"
	color_rect.color = Color("#0000ff")
	view_stats()

func view_stats():
	if cube_selected == 1:
		# Placeholder debug prints
		print("Cube was selected")
		print(cube_stat_HP)
		print(cube_stat_attack1)
		print(cube_stat_attack2)
		cube_selected = 2 # Set it to this vaulue so the proceed function can is allowed to start the game
	else:
		print("What") # This is line isn't needed as the function is only called once its value is updated and its only updated from 0 to 1

func _on_proceed_to_game_pressed() -> void:
	if cube_selected ==  2:
		get_tree().change_scene_to_file("res://game/main.tscn")
	else:
		# Make it easier to call by variables
		var error_popup = AcceptDialog.new()
		
		# Create the title and text of the popup
		error_popup.title = "Error"
		error_popup.dialog_text = "You've got to pick a cube before entering combat."
		
		# Add it to the scene
		add_child(error_popup)
		
		# Show the popup in the center of the screen
		error_popup.popup_centered()
		
		# Cleanup once its closed
		error_popup.canceled.connect(error_popup.queue_free)
		error_popup.confirmed.connect(error_popup.queue_free)

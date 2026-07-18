extends Node

var cube_selected = 0

@onready var lable: Label = $Lable
@onready var color_rect: ColorRect = $ColorRect

func _on_sword_master_pressed() -> void:
	cube_selected = 1
	color_rect.color = Color("#0000ff")
	view_stats()

func view_stats():
	if cube_selected == 1:
		print("Cube was selected")

extends Control

func _ready():
	hide()

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
	


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

		
func changeVariable(variable):
	variable = !variable

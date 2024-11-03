extends Control

func _on_home_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_next_level_pressed():
	if Global.niveles_ganados < Global.levels.size():
		get_tree().change_scene_to_file(Global.levels[Global.niveles_ganados])
		Global.niveles_ganados += 1
		print(Global.niveles_ganados)
	else:
		print("¡Has completado todos los niveles!")
		get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _ready():
	if Global.niveles_ganados == 2:
		$CanvasLayer/Panel/NextLevel.queue_free()     



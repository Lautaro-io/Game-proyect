extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/Label.text = """PERDISTE!
	VUELVE A INTENTAR
	""" 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	get_tree().reload_current_scene()

extends Control
var sonido_activo = true

var soundOn = preload("res://Assets/buttons_main/SoundOn/Default.svg")
var soundOff = preload("res://Assets/buttons_main/SoundOff/Default.svg") 
# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		Trans.change_scene("res://scenes/niveles/main.tscn")


func _on_texture_button_pressed():
	Trans.change_scene("res://scenes/niveles/main.tscn")
	$AudioStreamPlayer2D.stop()


func _on_sound_button_pressed():
	sonido_activo = !sonido_activo
	if sonido_activo:
		$SoundButton.texture_normal = soundOn
		$AudioStreamPlayer2D.play()
	else:
		$SoundButton.texture_normal = soundOff
		$SoundButton.texture_hover = preload("res://Assets/buttons_main/SoundOff/Hover.svg")
		$AudioStreamPlayer2D.stop()
		


func _on_exit_button_pressed():
	get_tree().quit()

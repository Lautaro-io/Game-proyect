extends Node2D
var tiempo_restante = 60
var pausable = true
var cambiarScene = false
var letras_encontradas = 0

func _ready():
	$CanvasLayer/GameOver/CanvasLayer/Label.hide()
	$win/win_pop.hide()
	$CanvasLayer/PauseMenu/CanvasLayer.hide()
	$win/win_pop/CanvasLayer.hide()
	var audio_stream = preload("res://Nivel3/hugo.ogg")
	if audio_stream is AudioStream: 
		audio_stream.loop = true   
		$AudioStreamPlayer2D.stream = audio_stream 
	$AudioStreamPlayer2D.play()  


func  _process(delta):
	if Input.is_action_just_pressed("pause") and pausable == true:
		pause_level()
	elif Input.is_action_just_pressed("pause") and pausable == false:
		continue_level()
	if get_tree().paused: #VERIFICA SI EL JUEGO ESTA PAUSADO, PARA QUE EL CONTRARELOJ NO CORRA. 
		return
	if letras_encontradas < 8:
		$CanvasLayer/Letras_encontradas.text = "LETRAS ENCONTRADAS :" + "".join($Player.letras_recogidas)
		$CanvasLayer/Tiempo_restante.text = "TIEMPO RESTANTE : " + str(round(tiempo_restante))
		tiempo_restante -= delta
		if tiempo_restante <= 0 and not cambiarScene:
			cambiarScene = true
			tiempo_restante = 0
			game_over()
	else:
		$WinSound.play()
		level_completed()



func pause_level():
	if pausable:
		$CanvasLayer/PauseMenu/CanvasLayer.show()
		get_tree().paused = true
		pausable = false	
	else:
		continue_level()
		
func continue_level():
	pausable = true
	$CanvasLayer/PauseMenu/CanvasLayer.hide()
	get_tree().paused = false
func resume_level():
	$CanvasLayer/PauseMenu.changeVariable(pausable)

func game_over():
	$CanvasLayer/GameOver/Timer.start()
	$CanvasLayer/GameOver/CanvasLayer/Label.show()

func level_completed():
	$win/win_pop/CanvasLayer.show()
func _on_colisiones_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().reload_current_scene()
		body.dead()


func _on_colisiones_p_inchos_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().reload_current_scene()


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body.recolectar_letras("S")
		letras_encontradas+=1
		$Letras/letraS.queue_free()


func _on_area_2d_2_body_entered(body):
	if body.is_in_group("Player"):
		body.recolectar_letras("I")
		letras_encontradas+=1
		$Letras/letraI.queue_free()


func _on_area_2d_3_body_entered(body):
	if body.is_in_group("Player"):
		body.recolectar_letras("T")
		letras_encontradas+=1
		$Letras/letraT.queue_free()


func _on_area_2d_4_body_entered(body):
	if body.is_in_group("Player"):
		body.recolectar_letras("L")
		letras_encontradas+=1
		$Letras/letraL1.queue_free()


func _on_area_2d_5_body_entered(body):
	if body.is_in_group("Player"):
		body.recolectar_letras("A")
		letras_encontradas+=1
		$Letras/letraA.queue_free()


func _on_area_2d_6_body_entered(body):
	if body.is_in_group("Player"):
		body.recolectar_letras("O")
		letras_encontradas+=1
		$Letras/letraO.queue_free()


func _on_area_2d_7_body_entered(body):
	if body.is_in_group("Player"):
		body.recolectar_letras("C")
		letras_encontradas+=1
		$Letras/letraC.queue_free()


func _on_area_2d_8_body_entered(body):
	if body.is_in_group("Player"):
		body.recolectar_letras("L")
		letras_encontradas+=1
		$Letras/letraL2.queue_free()


func _on_mar_2_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().reload_current_scene()

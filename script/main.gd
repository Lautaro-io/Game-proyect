extends Node2D
class_name Level

var tiempo_final = 50
var nivel_completo:bool = false
var letras_encontradas: = 0
var pausable = true
var cambiarDeEscena = false


func _ready():
	$CanvasLayer/Mensaje_cofre.hide()
	$CanvasLayer/NPC_TALK.hide()
	$CanvasLayer/GameOver/CanvasLayer/Label.hide()
	start_level()
	$CanvasLayer/PauseMenu/CanvasLayer.hide()
	$win/win_pop/CanvasLayer.hide()
	$CanvasLayer/Consigna/VBoxContainer/CanvasLayer/Panel/Label.text = """ "Es un líquido transparente que bebemos y que cae del cielo cuando llueve."
Junta las letras y forma   la palabra correcta """

	var audio_stream = preload("res://Assets/Sonidos/FondoMusica.ogg")
	if audio_stream is AudioStream: 
		audio_stream.loop = true   
		$AudioStreamPlayer2D.stream = audio_stream 
	$AudioStreamPlayer2D.play()  

	
func _process(delta):
	if Input.is_action_just_pressed("pause") and pausable == true:
		pause_level()
	elif Input.is_action_just_pressed("pause") and pausable == false:
		continue_level()
	if get_tree().paused: #VERIFICA SI EL JUEGO ESTA PAUSADO, PARA QUE EL CONTRARELOJ NO CORRA. 
		return
	else:
		resume_level()
	if letras_encontradas < 4:
		$CanvasLayer/Tiempo_restante.text = "TIEMPO RESTANTE = " + str(round(tiempo_final)) + " SEGUNDOS."
		$CanvasLayer/Letras_encontradas.text ="LETRAS ENCONTRADAS = " + "".join($Player.letras_encontradas)
		$CanvasLayer/Cant_monedas.text = "MONEDAS =" + str($Player.monedas)	
		tiempo_final -= delta
		if tiempo_final < 1 and not cambiarDeEscena:
			cambiarDeEscena = true
			tiempo_final = 0
			game_over()
			
	else: 
		$WinSound.play()
		nivel_completado()
func pause_level():
	if pausable:
		$CanvasLayer/PauseMenu/CanvasLayer.show()
		get_tree().paused = true
		print("Juego pausado")
		pausable = false	
	else:
		print("Despausando")
		continue_level()
		
func continue_level():
	pausable = true
	$CanvasLayer/PauseMenu/CanvasLayer.hide()
	get_tree().paused = false
func resume_level():
	$CanvasLayer/PauseMenu.changeVariable(pausable)

func start_level():
	$CanvasLayer/Consigna.show()
	$CanvasLayer/Consigna/Timer.start()
	get_tree().paused  = true
	
func nivel_completado():
	nivel_completo = true
	#$WinSound.play()
	$win/win_pop/CanvasLayer.show()
	letras_encontradas = 0

func timer_game_over():
	$CanvasLayer/GameOver/Contador.start()
	
func game_over():
	tiempo_final = 0
	$CanvasLayer/GameOver/Timer.start()
	$CanvasLayer/GameOver/CanvasLayer/Label.show()


func _on_vacio_body_entered(body):
	if body.is_in_group("player"):
		game_over()
		$AudioStreamPlayer2D.stop()
		$DeadSound.play()



func _on_cofre_area_body_entered(body):
	if body.is_in_group("player"):
		$Cofre.animation()
		$CanvasLayer/Mensaje_cofre/Timer.start()
		$CanvasLayer/Mensaje_cofre.show()
		$CanvasLayer/Mensaje_cofre.text = "10 SEGUNDOS DE REGALO. "		
		tiempo_final += 10
		$Cofre/cofre_area.queue_free() 



func _on_timer_timeout():
	$CanvasLayer/Mensaje_cofre.hide()


func _on_area_2d_body_entered(body):
	$CanvasLayer/NPC_TALK.show()
	if len(body.letras_encontradas) > 0:
		$CanvasLayer/NPC_TALK.text = "FELICIDADES, ENCONTRASTE TU PRIMERA LETRA, SIGUE TU CAMINO. "
	else:
		$CanvasLayer/NPC_TALK.text = "HAS OLVIDADO UNA LETRA AMIGO VUELVE TUS PASOS Y REGRESA POR LAS DEMAS.
		"


func _on_area_2d_body_exited(body):
	$CanvasLayer/NPC_TALK.hide()

##############                 LETRAS              #################
func _on_letra_a_body_entered(body):
	if body.is_in_group("player"):
		body.add_letter("A")
		letras_encontradas += 1
		$Palabra/letra_A.queue_free()


func _on_letra_g_body_entered(body):
	if body.is_in_group("player"):
		body.add_letter("G")
		letras_encontradas += 1
		$Palabra/letra_G.queue_free()

func _on_letra_u_body_entered(body):
	if body.is_in_group("player"):
		body.add_letter("U")
		letras_encontradas += 1
		$Palabra/letra_U.queue_free()

func _on_letra_a_2_body_entered(body):
	if body.is_in_group("player"):
		body.add_letter("A")
		letras_encontradas += 1
		$Palabra/letra_A2.queue_free()
########### FIN DE LETRAS - COMIENZO PLATAFORMAS #################
func _on_area_plat_body_entered(body):
	if body.is_in_group("player"):
		$Plataforma_gravitatoria/Timer.start()


func _on_area_plat_2_body_entered(body):
	if body.is_in_group("player"):
		$Plataforma_gravitatoria2/Timer.start()


func _on_area_plat_3_body_entered(body):
	if body.is_in_group("player"):
		$Plataforma_gravitatoria3/Timer.start()
	

func _on_area_plat_4_body_entered(body):
	if body.is_in_group("player"):
		$Plataforma_gravitatoria4/Timer.start()
	


####### MONEDAS ###########3
func _on_moneda_body_entered(body):
	if body.is_in_group("player"):
		body.add_coin()
		$Moneda.queue_free() 
		
func _on_moneda_2_body_entered(body):
	if body.is_in_group("player"):
		body.add_coin()
		$plataforma/Moneda2.queue_free() 

func _on_moneda_3_body_entered(body):
	if body.is_in_group("player"):
		body.add_coin()
		$Moneda3.queue_free() 

func _on_moneda_4_body_entered(body):
	if body.is_in_group("player"):
		body.add_coin()
		$Moneda4.queue_free() 


func _on_moneda_5_body_entered(body):
	if body.is_in_group("player"):
		body.add_coin()
		$Moneda5.queue_free() 
		
func _on_moneda_6_body_entered(body):
	if body.is_in_group("player"):
		body.add_coin()
		$Moneda6.queue_free() 
func _on_moneda_7_body_entered(body):
	if body.is_in_group("player"):
		body.add_coin()
		$Moneda7.queue_free() 


func _on_timer_game_timeout():
	print("timeout")
	get_tree().reload_current_scene()

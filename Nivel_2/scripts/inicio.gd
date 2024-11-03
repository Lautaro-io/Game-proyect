extends Node2D
var letras_encontradas = 0
var tiempo_restante = 60
var pausable = true
var cambiarScene = false

func _ready():
	$CanvasLayer/GameOver/CanvasLayer/Label.hide()
	$win/win_pop.hide()
	$CanvasLayer/PauseMenu/CanvasLayer.hide()
	$win/win_pop/CanvasLayer.hide()


func  _process(delta):
	if Input.is_action_just_pressed("pause") and pausable == true:
		pause_level()
	elif Input.is_action_just_pressed("pause") and pausable == false:
		continue_level()
	if get_tree().paused: #VERIFICA SI EL JUEGO ESTA PAUSADO, PARA QUE EL CONTRARELOJ NO CORRA. 
		return
	if letras_encontradas < 4:
		$CanvasLayer/Letras_encontradas.text = "LETRAS ENCONTRADAS :" + "".join($player.lista_palabra)
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

func game_over():
	$CanvasLayer/GameOver/Timer.start()
	$CanvasLayer/GameOver/CanvasLayer/Label.show()

func level_completed():
	$win/win_pop/CanvasLayer.show()
	
	
func _on_letra_o_body_entered(body):
	if body.is_in_group("player"):
		body.añadir_letra("O")
		letras_encontradas+=1
		$Palabra/Letra_O.queue_free()

func _on_letra_d_body_entered(body):
	if body.is_in_group("player"):
		body.añadir_letra("D")
		letras_encontradas+=1
		$Palabra/Letra_D.queue_free()

func _on_letra_i_body_entered(body):
	if body.is_in_group("player"):
		body.añadir_letra("I")
		letras_encontradas+=1
		$Palabra/Letra_I.queue_free()

func _on_letra_n_body_entered(body):
	if body.is_in_group("player"):
		body.añadir_letra("N")
		letras_encontradas+=1
		$Palabra/Letra_N.queue_free()

# NO PUDE HACER QUE LA PLATAFORMA SE ACTIVE
#CUANDO COLISIONE CON EL PLAYER

func _on_palizada_body_entered(body):
	if body.is_in_group("player"):
		get_tree().reload_current_scene()

func _on_caida_body_entered(body):
	if body.is_in_group("player"):
		get_tree().reload_current_scene()

func _on_area_npc_1_body_entered(body):
	if body.is_in_group("player"):
		$NPC1/TextureRect.show()

func _on_area_npc_1_body_exited(body):
	if body.is_in_group("player"):
		$NPC1/TextureRect.hide()

func _on_area_npc_2_body_entered(body):
	if body.is_in_group("player"):
		$NPC2/TextureRect.show()

func _on_area_npc_2_body_exited(body):
	if body.is_in_group("player"):
		$NPC2/TextureRect.hide()




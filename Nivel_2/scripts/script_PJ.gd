extends CharacterBody2D
@export var velocidad:int = 400
const gravedad = 980 
var velocidad_salto: int = 420
var lista_palabra = []
func _physics_process(delta):
	var direccion = 0
	if Input.is_action_pressed("move_right"):
		direccion = 1
	if Input.is_action_pressed("move_left"):
		direccion = -1
	velocity.x = velocidad * direccion
	desplazamiento()
	salto(delta)
	move_and_slide()

func desplazamiento():
	if velocity.x == 0:
		$Animacion.play("idle")
	elif velocity.x != 0:
		if velocity.x >0:
			$Animacion.play("run")
			$Animacion.flip_h = false
		elif velocity.x < 0:
			$Animacion.flip_h = true
			$Animacion.play("run")
	if velocity.y < 0:
		$Animacion.play("jump")
	elif not is_on_floor():
		$Animacion.play("fall")
		
func salto(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor() or Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -velocidad_salto
	else:
		velocity.y += gravedad * delta
		
func dead():
	pass
func añadir_letra(letra: String): # poner el tipo de dato string con S mayuscula siempre.
	lista_palabra.append(letra)

	

	
	
	
	
	




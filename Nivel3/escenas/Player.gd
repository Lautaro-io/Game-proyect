extends CharacterBody2D

var speed = 300.0
var jump_speed = -450.0
var gravity = 980

var letras_recogidas = []

func _physics_process(delta):
	var direction = 0
	if Input.is_action_pressed("move_right"):
		direction = 1
	if Input.is_action_pressed("move_left"):
		direction = -1

	velocity.x = direction * speed
	salto(delta)
	animacion()
	move_and_slide()

func animacion():
	if velocity.x == 0:
		$AnimatedSprite2D.play("Idle")
	elif velocity.x != 0:
		$AnimatedSprite2D.play("Run")
		if velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		elif velocity.x < 0:
			$AnimatedSprite2D.flip_h = true

func salto(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump_sound()
		velocity.y = jump_speed
	else:
		velocity.y += gravity * delta
func pick_letter():
	$PickLetterSound.play()
	$PickLetterSound.seek(0.51)
	
func jump_sound():
	$Jump.play()
	$Jump.seek(0.2)
	
func recolectar_letras(letra):
	pick_letter()
	letras_recogidas.append(letra)
	

func dead():
	set_physics_process(false)
	$AnimatedSprite2D.play("Death")
	await ($AnimatedSprite2D.animation_finished)
	queue_free()
	

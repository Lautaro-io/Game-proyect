extends CharacterBody2D
class_name cPlayer

var speed:int = 300
var jump_velocity = 500
const GRAVITY = 980
var max_jumps = 2
var count_jump = 0
var letras_encontradas = []
var monedas:int = 0
var hit_player = false
var taking_damage = false
var start_position = Vector2()


func pick_letter():
	$PickLetterSound.play()
	$PickLetterSound.seek(0.51)
	
func jump_sound():
	$Jump.play()
	$Jump.seek(0.2)
	
func _ready():
	start_position = position
	pass
	
func _physics_process(delta):
	anim()
	jump(delta)
	move_x()
	move_and_slide()
	
func move_x():
	var direction = 0
	if taking_damage:
		return 
	if  Input.is_action_pressed("move_right"):
		direction = 1
	if  Input.is_action_pressed("move_left"):
		direction = -1
	velocity.x = direction * speed
	
func anim():
	if velocity.x == 0:
		$AnimatedSprite2D.play("idle")
	elif velocity.x != 0:
		$AnimatedSprite2D.play("walk")
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	if velocity.y < 0:
		$AnimatedSprite2D.play("jump")
	if velocity.y > 0 :
		$AnimatedSprite2D.play("fall")
		
func jump(delta):
	if is_on_floor():
		count_jump = 0
		if Input.is_action_pressed("jump"):
			velocity.y = -jump_velocity
			jump_sound()
			count_jump += 1

	if not is_on_floor():
		velocity.y += GRAVITY * delta


func add_letter(letter:String):
	letras_encontradas.append(letter)
	pick_letter()
	
	
func add_coin():
	monedas+=50
	$CoinSound.play()

func take_damage():
	velocity = Vector2(-800,-200)
	taking_damage = true
	$damage.start()

func _on_damage_timeout():
	taking_damage = false

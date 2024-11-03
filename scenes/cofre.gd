extends StaticBody2D
var abierto = false

func animation():
	if !abierto: 
		$AnimatedSprite2D.play("default")
		abierto = true
		

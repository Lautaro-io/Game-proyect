extends Node2D

func _ready():
	$TextureRect.hide()
	$StaticBody2D/Animacion.play("idle")
	$StaticBody2D/CollisionShape2D.disabled = true







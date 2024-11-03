extends Area2D


func _ready():
	$AnimatedSprite2D.play("Idle")
	
func on_body_entedered(body):
	if body.is_in_group("Player"):
		get_parent().respawn = true
		$AnimatedSprite2D.play("Idle")
		await ($AnimatedSprite2D.animation_finished)
		$AnimatedSprite2D.play("Death")

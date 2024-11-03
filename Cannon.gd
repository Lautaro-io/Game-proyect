extends StaticBody2D
@export var bullet:PackedScene
var is_shooting:bool = true
func _ready():
	$AnimatedSprite2D.play("idle")
	
func _process(delta):
	if $RayCast2D.is_colliding():
		var obj = $RayCast2D.get_collider()
		if obj.is_in_group("player") and is_shooting:
			is_shooting = false
			$Timer.start()
			shoot()

func shoot():
	var newBullet = bullet.instantiate()
	newBullet.global_position = $Marker2D.global_position
	get_parent().add_child(newBullet)
	$AnimatedSprite2D.play("shoot")
	await  $AnimatedSprite2D.animation_finished
	$AnimatedSprite2D.play("idle")

func _on_timer_timeout():
	is_shooting = true
	

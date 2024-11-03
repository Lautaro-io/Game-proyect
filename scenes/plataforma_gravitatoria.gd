extends RigidBody2D

var fall_delay = 1.0  
var is_falling = false  

func _ready():
	gravity_scale = 0

func caer():
	gravity_scale = 1

func _on_timer_timeout():
	caer()

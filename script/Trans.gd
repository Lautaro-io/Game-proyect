extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	layer = -1
	$AnimationPlayer.play("Traba")

func change_scene(path : String):
	layer = 1
	$AnimationPlayer.play("Traba")
	await($AnimationPlayer.animation_finished)
	get_tree().change_scene_to_file(path)
	$AnimationPlayer.play_backwards("Traba")
	layer = -1
	 

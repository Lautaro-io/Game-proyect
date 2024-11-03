extends Node2D

var Player = load("res://escenas/Player.tscn")

func _ready():
	var newplayer = Player.instantiate()
	newplayer.position = $spawnPlayer.position
	add_child(newplayer)

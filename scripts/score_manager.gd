extends Node2D

@onready var timer = $Timer

var username : String
var score : int = 0

func ufo_destroyed():
	score += 100

func game_over():
	timer.stop()

func reset():
	score = 0
	timer.start()

func _on_timer_timeout():
	score += 10

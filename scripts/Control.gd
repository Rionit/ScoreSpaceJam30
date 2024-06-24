extends Control

@onready var score = %Score

func _process(_delta):
	score.text = str(ScoreManager.score)

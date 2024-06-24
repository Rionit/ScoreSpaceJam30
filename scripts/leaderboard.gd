extends Control

@export var board_entry_scene : PackedScene

@onready var player_list = $ScorePanel/PlayerList

# Called when the node enters the scene tree for the first time.
func _ready():
	var labels = board_entry_scene.instantiate()
	labels.player_name = "NAME"
	labels.score = "SCORE"
	player_list.add_child(labels)
	
	LeaderboardManager._get_leaderboards()
	var board = await LeaderboardManager.leaderboard_retrieved
	for i in board:
		var entry = board_entry_scene.instantiate()
		entry.player_name = i["player"]["name"]
		entry.score = i["score"]
		player_list.add_child(entry)


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/world.tscn")

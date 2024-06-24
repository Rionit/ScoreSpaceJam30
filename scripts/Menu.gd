extends Control

@onready var play = %Play
@onready var username = %Username
@onready var connecting = %Connecting

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if LeaderboardManager.session_token != "":
		connecting.visible = false
		if username.text.length() > 3 and username.text.length() < 20:
			play.disabled = false
		else:
			play.disabled = true
	else:
		connecting.visible = true
		play.disabled = true

func _on_play_pressed():
	ScoreManager.username = username.text
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	LeaderboardManager._change_player_name()

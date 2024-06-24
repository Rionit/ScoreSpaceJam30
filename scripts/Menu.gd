extends Control

@onready var play = %Play
@onready var username = %Username
@onready var connecting = %Connecting
@onready var unique = %Unique
var existing_name : String

func _ready():
	await LeaderboardManager.authenticated
	LeaderboardManager._get_player_name()
	existing_name = await LeaderboardManager.get_name_responded
	username.text = existing_name

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
	
	if username.text != existing_name:
		LeaderboardManager._change_player_name()
		var response = await LeaderboardManager.change_name_responded
		if !response:
			unique.visible = true
			return
	
	unique.visible = false
	get_tree().change_scene_to_file("res://scenes/world.tscn")

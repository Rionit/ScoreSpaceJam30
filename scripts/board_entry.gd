extends HBoxContainer

var player_name := "test"
var score

@onready var name_label = $Name
@onready var score_label = $Score

	
# Called when the node enters the scene tree for the first time.
func _ready():
	update_labels()

func update_labels():
	name_label.text = player_name
	score_label.text = str(score)

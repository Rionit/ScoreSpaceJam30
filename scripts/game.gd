extends Node

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit() # default behavior

func _input(event):
	if event.is_action_pressed("escape"):
		get_tree().quit()

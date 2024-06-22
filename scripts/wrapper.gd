extends Node2D

var screen_size : Vector2

@export var obj_width : int = 50
@export var obj_height : int = 50

signal wrapped(new_position)

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var x = global_position.x
	var y = global_position.y
	
	if global_position.y < -obj_height:
		y = screen_size.y
	elif global_position.y > screen_size.y + obj_height:
		y = 0
	
	if global_position.x < -obj_width:
		x = screen_size.x 
	elif global_position.x > screen_size.x + obj_width:
		x = 0
	
	if x != global_position.x or y != global_position.y:
		wrapped.emit(Vector2(x, y))

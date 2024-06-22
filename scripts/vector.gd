extends Node2D

var start := Vector2.ZERO
var end := Vector2.ZERO
var vector := Vector2.ZERO
var maximum_length = 100

func _draw() -> void:
	draw_line(start - global_position, 
		(end - global_position), 
		Color.BLUE, 
		8)
	
	draw_line(start - global_position, 
		start - global_position + vector, 
		Color.RED, 
		16)
		
func refresh(_start, _end):
	start = _start
	end = _end
	vector = -(end - start)
	queue_redraw()

extends CharacterBody2D

@onready var player : CharacterBody2D = %Player
var asteroids : Dictionary = {}
var avoidance_distance := 100.0
var avoidance_direction := Vector2.ZERO
var random_offset := Vector2.ZERO

func _draw():
	draw_line(Vector2.ZERO, 
		velocity, 
		Color.BLUE, 
		8)

func _on_hitbox_body_entered(body):
	if body.is_in_group("asteroids"):
		body.queue_free()
		queue_free()
		
func _on_surroundings_body_entered(body):
	if body.is_in_group("asteroids"):
		asteroids[body.get_instance_id()] = body

func _on_surroundings_body_exited(body):
	if body.is_in_group("asteroids"):
		asteroids.erase(body.get_instance_id())

func _check_asteroid_avoidance() -> Vector2:
	var total_avoidance := Vector2.ZERO
	for asteroid_id in asteroids.keys():
		var asteroid = asteroids[asteroid_id]
		if asteroid and asteroid.position.distance_to(position) < avoidance_distance:
			total_avoidance += _avoid_asteroid(asteroid)
	return total_avoidance
	
func _avoid_asteroid(asteroid) -> Vector2:
	var direction_to_asteroid = asteroid.position - position
	avoidance_direction = -direction_to_asteroid.normalized()
	return avoidance_direction * 100

func _seek_player() -> Vector2:
	var path = player.global_position - global_position
	var direction = path.normalized()
	var distance = abs(path.length()) 
	if distance > 100:
		return direction * 100 + random_offset 
	else:
		return direction * 100

func _process(delta):
	var avoidance = _check_asteroid_avoidance()
	var seek = _seek_player()
	velocity = avoidance + seek
	queue_redraw()
	move_and_slide()

func _on_timer_timeout():
	random_offset = Vector2(randi_range(-100, 100), randi_range(-100, 100)) 
	print("Changed offset: " + str(random_offset))

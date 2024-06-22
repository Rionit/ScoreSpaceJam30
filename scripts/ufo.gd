extends CharacterBody2D

var asteroids : Dictionary = {}
var avoidance_distance : float = 100.0

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

func _check_asteroid_avoidance():
	for asteroid_id in asteroids.keys():
		var asteroid = asteroids[asteroid_id]
		if asteroid and asteroid.position.distance_to(position) < avoidance_distance:
			_avoid_asteroid(asteroid)

func _avoid_asteroid(asteroid):
	var direction_to_asteroid = asteroid.position - position
	var avoidance_direction = -direction_to_asteroid.normalized()
	velocity = avoidance_direction * 100
	print("avoiding in dir: " + str(velocity))
	move_and_slide()


func _on_timer_timeout():
	_check_asteroid_avoidance()

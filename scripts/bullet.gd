extends RigidBody2D
class_name Bullet

var creator
@onready var bullet_sound = $BulletSound

func _ready():
	bullet_sound.play()

func _on_area_2d_body_entered(body):
	if body.is_in_group("asteroids") or body.is_in_group("aliens") and body != creator:
		body.destroy()
		call_deferred("queue_free")

func _on_ttl_timeout():
	queue_free()

func _on_wrapper_wrapped(new_position):
	position = new_position

extends RigidBody2D

var creator

func _on_area_2d_body_entered(body):
	if body.has_method("destroy") and body != creator:
		body.destroy()
		call_deferred("queue_free")

func _on_ttl_timeout():
	queue_free()

func _on_wrapper_wrapped(new_position):
	position = new_position

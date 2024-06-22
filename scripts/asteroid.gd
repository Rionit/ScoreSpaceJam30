extends RigidBody2D

const _f = 50
const _a = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var loc = Vector2(randf_range(-_f, _f), randf_range(-_f, _f))
	var offset = Vector2(randf_range(-_f, _f), randf_range(-_f, _f))
	apply_impulse(loc, offset)
	angular_velocity = randf_range(-_a, _a)

func destroy():
	queue_free()

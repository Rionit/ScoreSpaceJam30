extends RigidBody2D
class_name Asteroid

const scene: PackedScene = preload("res://scenes/asteroid.tscn")

@onready var animation_player = $AnimationPlayer

enum sizes { SMALL, MEDIUM, LARGE }
var anims = { sizes.SMALL: "small",
			  sizes.MEDIUM: "medium",
			  sizes.LARGE: "large"}
var screen_size = get_viewport_rect().size
var size = sizes.values().pick_random()

const _f = 50
const _a = 5

static func new_asteroid(size: int, velocity: Vector2, _position: Vector2) -> Asteroid:
	var new_asteroid: Asteroid = scene.instantiate()
	new_asteroid.size = size
	new_asteroid.apply_impulse(velocity)
	new_asteroid.position = _position
	return new_asteroid

func _draw():
	var unrotated = linear_velocity.rotated(-rotation)
	draw_line(Vector2.ZERO, 
		unrotated.clamp(Vector2(-200, -200), Vector2(10000, 10000)), 
		Color.DARK_GREEN, 
		4)

# Called when the node enters the scene tree for the first time.
func _ready():
	if size in anims:
		animation_player.play(anims[size])
	
	randomize()
	var loc = Vector2(randf_range(-_f, _f), randf_range(-_f, _f))
	var offset = Vector2(randf_range(-_f, _f), randf_range(-_f, _f))
	apply_impulse(loc, offset)
	angular_velocity = randf_range(-_a, _a)
	
	#print("I am size: " + str(size))
	
func _process(delta):
	queue_redraw()

func destroy() -> void:
	if size != sizes.SMALL:
		var debris = [duplicate(), duplicate()]
		for debree in debris:
			debree.size = size - 1
			debree.linear_velocity = -linear_velocity.rotated(randf())
			get_parent().add_child(debree)
		
	queue_free()

func pickup():
	queue_free()

func _on_wrapper_wrapped(new_position):
	position = new_position

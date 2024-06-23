extends Node2D

var asteroids : Array
var ufos : Array
var default_n := randi_range(4, 10)
var screen_size : Vector2

@onready var asteroid_spawner = %AsteroidSpawner
@onready var ufo_spawner = %UfoSpawner
@onready var player = %Player

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screen_size = get_viewport_rect().size
	
	for i in default_n:
		spawn_asteroid()
	
	asteroid_spawner.wait_time = randi_range(5, 15)

func spawn_asteroid():
	var instance = Asteroid.new_asteroid(
							Asteroid.sizes.values().pick_random(),
							Vector2(randi_range(-100, 100), randi_range(-100, 100)),
							Vector2(randi_range(0, screen_size.x), randi_range(0, screen_size.y)))
	asteroids.push_back(instance)
	add_child(instance)

func spawn_ufo():
	var instance = UFO.new_ufo(Vector2(randi_range(0, screen_size.x), randi_range(0, screen_size.y)))
	instance.player = player
	ufos.push_back(instance)
	add_child(instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_asteroid_spawner_timeout():
	spawn_asteroid()
	asteroid_spawner.wait_time = randi_range(15, 30)


func _on_timer_timeout():
	spawn_ufo()
	ufo_spawner.wait_time = randi_range(5, 20)

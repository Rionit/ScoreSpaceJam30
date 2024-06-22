extends CharacterBody2D

enum sm { IDLE, HOLDING, AIMING}

@onready var spawner = %Spawner
@onready var pointer = $Pointer

var asteroid = preload("res://scenes/asteroid.tscn")

var click_position : Vector2 = Vector2.ZERO
var click_direction : Vector2 = Vector2.ZERO
var dir : Vector2 = Vector2.ZERO
var state : sm = sm.IDLE

const force := 100

func _ready():
	velocity = Vector2(0, -force)

func _input(event):
	if event is InputEventMouse:
		click_direction = event.position

func get_direction():
	return (click_position - click_direction).normalized()

func throw_asteroid(_velocity):
	var instance = asteroid.instantiate()
	instance.position = spawner.global_position
	get_parent().add_child(instance)
	instance.apply_impulse(-_velocity)

func holding():
	if Input.is_action_just_pressed("left_click"):
		click_position = get_global_mouse_position()
		state = sm.AIMING

func aiming():
	look_at(position - get_direction())
	if Input.is_action_just_released("left_click"):
		state = sm.IDLE
		var _velocity = get_direction() * force
		velocity = _velocity
		throw_asteroid(_velocity)

func _physics_process(delta):
	
	match state:
		sm.IDLE:
			#state = sm.HOLDING # TEMPORARY!!
			pass
		sm.HOLDING:
			holding()
		sm.AIMING:
			aiming()
	
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.is_in_group("asteroids") and state == sm.IDLE:
		velocity = velocity / 2
		state = sm.HOLDING
		body.destroy()

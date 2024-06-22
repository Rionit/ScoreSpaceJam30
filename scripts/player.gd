extends CharacterBody2D

enum sm { IDLE, HOLDING, AIMING}

@onready var pointer = $Pointer
var asteroid = preload("res://scenes/asteroid.tscn")

var click_position : Vector2 = Vector2.ZERO
var click_direction : Vector2 = Vector2.ZERO

var state : sm = sm.IDLE
var dir : Vector2 = Vector2.ZERO

const force := 100

func _input(event):
	if event is InputEventMouse:
		click_direction = event.position

func get_direction():
	return (click_position - click_direction).normalized()

func throw_asteroid(_velocity):
	var instance = asteroid.instantiate()
	instance.position = global_position
	get_parent().add_child(instance)
	instance.apply_impulse(-_velocity)

func _physics_process(delta):
	
	match state:
		sm.IDLE:
			state = sm.HOLDING
		sm.HOLDING:
			if Input.is_action_just_pressed("left_click"):
				click_position = get_global_mouse_position()
				state = sm.AIMING
		sm.AIMING:
			look_at(position - get_direction())
			if Input.is_action_just_released("left_click"):
				state = sm.IDLE
				var _velocity = get_direction() * force
				velocity = _velocity
				throw_asteroid(_velocity)
	
	move_and_slide()

extends CharacterBody2D

@onready var pointer = $Pointer
var asteroid = preload("res://scenes/asteroid.tscn")

var click_position : Vector2 = Vector2.ZERO
var click_direction : Vector2 = Vector2.ZERO

var aiming : bool = false
var dir : Vector2 = Vector2.ZERO

const force := 100

func _input(event):
	if event is InputEventMouse:
		click_direction = event.position

func get_direction():
	return (click_position - click_direction).normalized()

func _physics_process(delta):
	
	
	if Input.is_action_just_pressed("left_click"):
		click_position = get_global_mouse_position()
		aiming = true
	
	if Input.is_action_just_released("left_click"):
		aiming = false
		var _velocity = get_direction() * force
		velocity = _velocity
		var instance = asteroid.instantiate()
		instance.position = global_position
		get_parent().add_child(instance)
		instance.apply_impulse(-_velocity)
	
	if aiming:
		pointer.look_at(position - get_direction())
	
	move_and_slide()

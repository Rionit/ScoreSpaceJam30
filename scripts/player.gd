extends CharacterBody2D

enum sm { IDLE, HOLDING, AIMING }

@onready var spawner = %Spawner
@onready var pointer = %Pointer
@onready var rotables = $Rotables
@onready var vector = $Vector

var asteroid = preload("res://scenes/asteroid.tscn")

var click_start : Vector2 = Vector2.ZERO
var click_end : Vector2 = Vector2.ZERO
var state : sm = sm.IDLE

const max_force := 600

func _ready():
	velocity = Vector2(0, -200)

func _input(event):
	if event is InputEventMouse:
		click_end = event.position

func get_direction():
	return (click_start - click_end).normalized()

func get_force():
	return clamp((click_end - click_start).length(), 0, max_force)

func throw_asteroid(_velocity):
	var instance = asteroid.instantiate()
	instance.position = spawner.global_position
	get_parent().add_child(instance)
	instance.apply_impulse(-_velocity)

func holding():
	if Input.is_action_just_pressed("left_click"):
		click_start = get_global_mouse_position()
		state = sm.AIMING

func aiming():
	vector.visible = true
	vector.refresh(click_start, click_end)
	rotables.look_at(position - get_direction())
	if Input.is_action_just_released("left_click"):
		state = sm.IDLE
		var _velocity = get_direction() * get_force()
		velocity = _velocity
		throw_asteroid(_velocity)
		vector.visible = false

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


func _on_wrapper_wrapped(new_position):
	position = new_position

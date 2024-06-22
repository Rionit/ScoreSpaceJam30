extends CharacterBody2D

@onready var pointer = $Pointer

var click_position : Vector2 = Vector2.ZERO
var click_direction : Vector2 = Vector2.ZERO

var aiming : bool = false
var dir : Vector2 = Vector2.ZERO

const force := 100

func _input(event):
	if event is InputEventMouse:
		click_direction = event.position

func _physics_process(delta):
	
	if Input.is_action_just_pressed("left_click"):
		click_position = get_global_mouse_position()
		aiming = true
	
	if Input.is_action_just_released("left_click"):
		aiming = false
		velocity = - (click_direction - position).normalized() * force
	
	if aiming:
		pointer.look_at(click_direction)
	
	
	
	move_and_slide()

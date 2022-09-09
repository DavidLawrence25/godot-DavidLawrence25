# extensions
extends KinematicBody2D

# constants
const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

# variables
var velocity = Vector2.ZERO

# player physics
func _physics_process(delta):
	# input handler
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	# normalizes input
	input_vector = input_vector.normalized()
	
	# converts input to velocity
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	# cheaty movement function
	move_and_collide(velocity * delta)

# extensions
extends KinematicBody2D

# constants
const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

# variables
var velocity = Vector2.ZERO
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

# player physics
func _physics_process(delta):
	# input handler
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	# normalizes input
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		# animate
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		# converts input to velocity
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		# animate
		animationState.travel("Idle")
		# converts input to velocity
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	# cheaty movement function
	velocity = move_and_slide(velocity)

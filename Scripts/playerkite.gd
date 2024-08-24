extends CharacterBody3D

@onready var _player_visual = $PlayerVisual
var _physics_body_trans_last: Transform3D
var _physics_body_trans_current: Transform3D


var kitePosition = 0.0

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MIN_HEIGHT = 1.0 
const MAX_HEIGHT = 5.0

const MAX_TILT = 36.0  # Max tilt angle in degrees
const ROTATION_SPEED = 5.0  # Speed of rotation change

# TODO: Need follow dampening to the player node

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready() -> void:
	#prevents the visual node from being affected by the movement of its parent
	_player_visual.top_level = true

func _physics_process(delta):
	_physics_body_trans_last = _physics_body_trans_current
	_physics_body_trans_current = global_transform
	var kitePos = position.y + velocity.y
	
	
	
	if Input.is_action_pressed("kite_move_up"):
		position.y += SPEED * delta
		rotation.z = clamp(rotation.z + ROTATION_SPEED * delta, -deg_to_rad(MAX_TILT), deg_to_rad(MAX_TILT))
		#print("Kite move up")
	elif Input.is_action_pressed("kite_move_down"):
		position.y -= SPEED * delta
		rotation.z = clamp(rotation.z - ROTATION_SPEED * delta, -deg_to_rad(MAX_TILT), deg_to_rad(MAX_TILT))
		#print("Kite move down")
	else:
		# Smoothly return the kite to 0 degrees on the Z-axis when no input is given
		rotation.z = lerp(rotation.z, 0.0, 2.0 * delta)
	# Apply movement and clamp the Y position to keep the kite within bounds
	position.y = clamp(position.y + velocity.y, MIN_HEIGHT, MAX_HEIGHT)
	move_and_slide()
	

func _process(_delta: float) -> void:
	_player_visual.global_transform = \
		_physics_body_trans_last.interpolate_with(
			_physics_body_trans_current,
			Engine.get_physics_interpolation_fraction()
		)


extends CharacterBody3D

@onready var _player_visual = $PlayerVisual

const SPEED = 5
const JUMP_VELOCITY = 4.5

var _physics_body_trans_last: Transform3D
var _physics_body_trans_current: Transform3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var ray_cast_3d = $RayCast3D

# Add randomness
var z_direction = 0.0
var z_timer = 0.0

func _ready() -> void:
	#prevents the visual node from being affected by the movement of its parent
	_player_visual.top_level = true

func _physics_process(delta):
	_physics_body_trans_last = _physics_body_trans_current
	_physics_body_trans_current = global_transform
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if ray_cast_3d.is_colliding() and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	position.x += SPEED * delta
	#velocity.x += clamp(lerp(velocity.x,SPEED * delta, 0.5), 2.5, 5.0)
	
	# Randomly change the z direction at intervals
	z_timer -= delta
	if z_timer <= 0.0:
		z_direction = randf_range(-1.0, 1.0)  # Randomly choose a direction
		z_timer = randf_range(0.5, 2.0)  # Randomize how long to stay in that direction
	
	position.z += z_direction * SPEED * delta  # Move in the z direction
	
	move_and_slide()
	
func _process(_delta: float) -> void:
	_player_visual.global_transform = \
		_physics_body_trans_last.interpolate_with(
			_physics_body_trans_current,
			Engine.get_physics_interpolation_fraction()
		)

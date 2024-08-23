extends CharacterBody3D

@onready var _player_visual: Node3D  = $PlayerVisual
@onready var animated_sprite_3d = $PlayerVisual/AnimatedSprite3D

var _physics_body_trans_last: Transform3D
var _physics_body_trans_current: Transform3D

const SPEED = 5.0
const JUMP_VELOCITY = 9.5
const FALL_MULTIPLIER = 3.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	#prevents the visual node from being affected by the movement of its parent
	_player_visual.top_level = true

func _physics_process(delta):
	_physics_body_trans_last = _physics_body_trans_current
	_physics_body_trans_current = global_transform
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * FALL_MULTIPLIER * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		#trying out interpolation
		velocity.x = lerp(velocity.x, direction.x * SPEED, 0.5)
		velocity.z = lerp(velocity.z, direction.z * SPEED, 0.5)
		# Determine if moving left or right and flip the sprite accordingly
		if velocity.x > 0:
			animated_sprite_3d.flip_h = false  # Facing right
		elif velocity.x < 0:
			animated_sprite_3d.flip_h = true  # Facing left
		
		animated_sprite_3d.play("Run", 1.0, false)
		#velocity.x = direction.x * SPEED 
		#velocity.z = direction.z * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
		velocity.z = move_toward(velocity.z, 0, SPEED * delta)
		animated_sprite_3d.play("Idle", 1.0, false)

	move_and_slide()
	
func _process(_delta: float) -> void:
	_player_visual.global_transform = \
		_physics_body_trans_last.interpolate_with(
			_physics_body_trans_current,
			Engine.get_physics_interpolation_fraction()
		)

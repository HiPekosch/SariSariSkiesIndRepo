extends CharacterBody3D

@onready var _player_visual: Node3D  = $PlayerVisual
@onready var animated_sprite_3d = $PlayerVisual/AnimatedSprite3D

var _physics_body_trans_last: Transform3D
var _physics_body_trans_current: Transform3D
var speedModifier = 1.0

const SPEED = 5.0
const JUMP_VELOCITY = 9.5
const FALL_MULTIPLIER = 3.0
const COYOTE_LEEWAY = 0.2

var coyote_time = 0

var player : int
var input : DeviceInput

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	#prevents the visual node from being affected by the movement of its parent
	_player_visual.top_level = true
	player_init()

# TEMPORARY SOLUTION
# Just here for singleplayer
# In the near future, figure out where to call this
func player_init():
	player = 0
	
	var device = PlayerControlManager.get_player_device(player)
	input = DeviceInput.new(device)
	pass

func _physics_process(delta):
	_physics_body_trans_last = _physics_body_trans_current
	_physics_body_trans_current = global_transform
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * FALL_MULTIPLIER * delta
	
	# Coyote Time
	if is_on_floor():
		coyote_time = COYOTE_LEEWAY
	else:
		coyote_time -= delta
		if coyote_time < 0:
			coyote_time = 0
	
	# Handle jump.
	if input.is_action_just_pressed("player_jump") and coyote_time > 0:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = input.get_vector("player_move_left", "player_move_right", "player_move_up", "player_move_down")
	print(input_dir)
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		#trying out interpolation
		velocity.x = lerp(velocity.x, direction.x * speedModifier * SPEED, 0.5)
		velocity.z = lerp(velocity.z, direction.z * speedModifier * SPEED, 0.5)
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

func _on_area_3d_trigger_area_entered(area):
	if(area.is_in_group("boost")):
		speedModifier = 2.5

func _on_area_3d_trigger_area_exited(area):
	if(area.is_in_group("boost")):
		speedModifier = 1.0

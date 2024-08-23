extends CharacterBody3D

@onready var _player_visual = $PlayerVisual
var _physics_body_trans_last: Transform3D
var _physics_body_trans_current: Transform3D

var kitePosition = 0.0

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# TODO: Need follow dampening to the player node

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	#prevents the visual node from being affected by the movement of its parent
	_player_visual.top_level = true

func _physics_process(delta):
	_physics_body_trans_last = _physics_body_trans_current
	_physics_body_trans_current = global_transform

func _process(_delta: float) -> void:
	_player_visual.global_transform = \
		_physics_body_trans_last.interpolate_with(
			_physics_body_trans_current,
			Engine.get_physics_interpolation_fraction()
		)


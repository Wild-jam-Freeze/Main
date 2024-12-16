extends CharacterBody2D

@export var SPEED = 300
const ACCELERATION = 0.75
const FRICTION = 0.5

const TORCH_MAX_ANGLE = 35

var current_direction = Vector2.ZERO

@onready var walk_sfx: AudioStreamPlayer = $AudioStreamPlayer
@onready var animation_tree = $Animplayers/AnimationTree
@onready var torchlight = $PointLight2D

func _physics_process(delta):
	var input = Input.get_vector("left","right","up","down")
	player_movement(input)
	move_and_slide()
	play_direction_anim(input)
	light_direction_control()

func player_movement(input: Vector2):
	if input: 
		velocity = velocity.lerp(input * SPEED, ACCELERATION)
		current_direction = input
		walk_sfx.play()
	else: 
		walk_sfx.stop()
		velocity = velocity.lerp(Vector2.ZERO, FRICTION)

func play_direction_anim(input: Vector2):
	animation_tree.set("parameters/idle/blend_position", current_direction)
	animation_tree.set("parameters/walk/blend_position", current_direction)
	
	animation_tree.set("parameters/conditions/still", !input)
	animation_tree.set("parameters/conditions/walking", input != Vector2.ZERO)
	

func light_direction_control():
	var dir_center = current_direction.angle()
	var mouse_angle = get_local_mouse_position().angle()
	
	var clamped = clamp_angle(
		mouse_angle, 
		dir_center-deg_to_rad(TORCH_MAX_ANGLE), 
		dir_center+deg_to_rad(TORCH_MAX_ANGLE))
	
	torchlight.rotation = lerpf(torchlight.rotation, clamped, 0.2)
	

func clamp_angle(angle: float, min_angle: float, max_angle: float) -> float:
	var max_diff = abs(angle_difference(angle, max_angle))
	var min_diff = abs(angle_difference(angle, min_angle))
	
	if angle > max_angle or angle < min_angle:
		if max_diff < min_diff: return max_angle
		else: return min_angle
	return angle

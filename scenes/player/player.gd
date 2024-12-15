extends CharacterBody2D

const SPEED = 300
const ACCELERATION = 0.75
const FRICTION = 0.5

var current_direction = Vector2.ZERO

@onready var walk_sfx: AudioStreamPlayer = $AudioStreamPlayer
@onready var animation_tree = $Animplayers/AnimationTree
@onready var point_light_2d = $PointLight2D

func _physics_process(delta):
	var input = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	walk_sfx.play()
	player_movement(input)
	move_and_slide()
	play_direction_anim(input)

func player_movement(input: Vector2):
	if input: 
		velocity = velocity.lerp(input * SPEED, ACCELERATION)
		current_direction = input
	else: 
		velocity = velocity.lerp(Vector2.ZERO, FRICTION)

func play_direction_anim(input: Vector2):
	animation_tree.set("parameters/idle/blend_position", current_direction)
	animation_tree.set("parameters/walk/blend_position", current_direction)
	
	animation_tree.set("parameters/conditions/still", !input)
	animation_tree.set("parameters/conditions/walking", input != Vector2.ZERO)
	

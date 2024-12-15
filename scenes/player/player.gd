extends CharacterBody2D

const SPEED = 300
const ACCELERATION = 0.75
const FRICTION = 0.5

var current_direction = Vector2.ZERO

@onready var walk_sfx: AudioStreamPlayer = $AudioStreamPlayer

func player_movement(input, delta):
	if input: 
		velocity = velocity.lerp(input * SPEED, ACCELERATION)
	else: 
		velocity = velocity.lerp(Vector2.ZERO, FRICTION)

func _physics_process(delta):
	var input = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	walk_sfx.play()
	player_movement(input, delta)
	move_and_slide()
	play_direction_anim(delta)


func play_direction_anim(delta):
	var anim = $AnimatedSprite2D
	var point_light_2d: PointLight2D = $PointLight2D
	var input = Input.get_vector("ui_left","ui_right","ui_up","ui_down")

	var new_animation = ""

	if input.x != 0 or input.y != 0:
		current_direction = input

	if current_direction.x > 0 and velocity.length() > 0:
		new_animation = "walk_right"
		point_light_2d.position = Vector2(30, 0)
		point_light_2d.rotation = -1.6
	elif current_direction.x < 0 and velocity.length() > 0:
		new_animation = "walk_left"
		point_light_2d.position = Vector2(-30, 0)
		point_light_2d.rotation = 1.6
	elif current_direction.y > 0 and velocity.length() > 0:
		new_animation = "walk_down"
		point_light_2d.position = Vector2(0, 22.5)
		point_light_2d.rotation = 0
	elif current_direction.y < 0 and velocity.length() > 0:
		new_animation = "walk_up"
		point_light_2d.position = Vector2(0, -22.5)
		point_light_2d.rotation = 3.2
	else:
		if current_animation.ends_with("_right") and velocity.length() == 0:
			new_animation = "idle_right"
		elif current_animation.ends_with("_left") and velocity.length() == 0:
			new_animation = "idle_left"
		elif current_animation.ends_with("_down") and velocity.length() == 0:
			new_animation = "idle_down"
		elif current_animation.ends_with("_up") and velocity.length() == 0:
			new_animation = "idle_up"

	if new_animation != current_animation:
		anim.play(new_animation)
		current_animation = new_animation

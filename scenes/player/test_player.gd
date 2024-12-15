extends CharacterBody2D

var speed = 200;

@onready var chaser = get_tree().get_first_node_in_group("chaser")



func _physics_process(delta: float) -> void:
	var dir = Input.get_vector("left","right","up","down") *speed;
	velocity = dir;
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("chaser"):
		chaser.can_chase = false
		chaser.speed *= 0
		print("enterd")


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("chaser"):
		chaser.speed = 100

extends CharacterBody2D

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var wait_timer: Timer = $wait

@onready var player = get_tree().get_first_node_in_group("player");
@export var target : CharacterBody2D
var  speed =100;

var can_chase = false
var is_patrolling = true


var waypointIINDEX : int =0
@export var waypoints : Array[Marker2D]


func _physics_process(delta: float) -> void:
	patrol_state(is_patrolling)
	chase_state(can_chase,delta)
	move_and_slide()
	#print(is_patrolling)
	
	
	
	
func patrol_state(is_patrol:bool):
	if waypoints.size()>0 and is_patrolling == true:
		var target_pos = waypoints[waypointIINDEX].position
		velocity = (target_pos - position).normalized()*speed

		if position.distance_to(target_pos) < 10.0:
			waypointIINDEX +=1
			if waypointIINDEX >= waypoints.size():
				waypointIINDEX = 0

	
	
	
	
func chase_state(can_chase:bool,delta):
	if can_chase == true:
		var dir = Vector2.ZERO
		dir  =navigation_agent_2d.get_next_path_position() -global_position
		dir  = dir.normalized()
		velocity = velocity.lerp(dir*speed,delta)

		
		
		
		
		
func _on_timer_timeout() -> void:
	if can_chase == true:
		navigation_agent_2d.target_position = target.global_position


func _on_detect_body_entered(body: Node2D) -> void:
	is_patrolling = false
	can_chase = true


func _on_detect_body_exited(body: Node2D) -> void:
	can_chase = false
	wait_timer.start(3)


func _on_wait_timeout() -> void:
	is_patrolling = true

extends CharacterBody2D


@onready var timer: Timer = $Timer
@onready var player = get_tree().get_first_node_in_group("player")
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var start_timer = false

func _process(delta: float) -> void:
	animation_player.play("eyes")
	pass

func _on_watch_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		timer.start(2)
		
	


func _on_timer_timeout() -> void:
	print("died")


func _on_watch_area_body_exited(body: Node2D) -> void:
	timer.stop()

extends NodeState

@export var player :Player
@export var animated_sprite_2D : AnimatedSprite2D
@export var speed : int = 50

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var direction : Vector2 = GameInputEvent.movement_input()
	
	if direction == Vector2.UP:
		animated_sprite_2D.play("walk_front")
	elif direction == Vector2.DOWN:
		animated_sprite_2D.play("walk_back")
	elif direction == Vector2.LEFT:
		animated_sprite_2D.play("walk_left")
	elif direction == Vector2.RIGHT:
		animated_sprite_2D.play("walk_right")
##播放行走动画
		
	if direction !=Vector2.ZERO:
		player.play_direction = direction
		
	player.velocity = direction * speed
	player.move_and_slide()

func _on_next_transitions() -> void:
	if !GameInputEvent.movement_input():
		transition.emit("Idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2D.stop()

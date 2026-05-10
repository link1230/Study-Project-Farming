extends NodeState

@export var player :Player
@export var animated_sprite_2D : AnimatedSprite2D
@export var speed : int = 50

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	if not is_instance_valid(player) or not is_instance_valid(animated_sprite_2D):
		return
	
	var direction : Vector2 = GameInputEvent.movement_input()
	
	if direction == Vector2.UP:
		animated_sprite_2D.play("walk_front")
	elif direction == Vector2.DOWN:
		animated_sprite_2D.play("walk_back")
	elif direction == Vector2.LEFT:
		animated_sprite_2D.play("walk_left")
	elif direction == Vector2.RIGHT:
		animated_sprite_2D.play("walk_right")
		
	if direction !=Vector2.ZERO:
		player.play_direction = direction
		
	player.velocity = direction * speed
	player.move_and_slide()

func _on_next_transitions() -> void:
	if !GameInputEvent.movement_input():
		transition.emit("idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	if is_instance_valid(animated_sprite_2D):
		animated_sprite_2D.stop()

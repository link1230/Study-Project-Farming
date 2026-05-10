extends NodeState

@export var player:Player
@export var animated_sprite_2d : AnimatedSprite2D


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if not is_instance_valid(animated_sprite_2d) or !animated_sprite_2d.is_playing():
		transition.emit("idle")


func _on_enter() -> void:
	if not is_instance_valid(animated_sprite_2d) or not is_instance_valid(player):
		return
	
	if player.play_direction == Vector2.UP:
		animated_sprite_2d.play("dig_back")
	elif player.play_direction == Vector2.DOWN:
		animated_sprite_2d.play("dig_front")
	elif player.play_direction == Vector2.RIGHT:
		animated_sprite_2d.play("dig_right")
	elif player.play_direction == Vector2.LEFT:
		animated_sprite_2d.play("dig_left")
	else:
		animated_sprite_2d.play("dig_front")


func _on_exit() -> void:
	if is_instance_valid(animated_sprite_2d):
		animated_sprite_2d.stop()

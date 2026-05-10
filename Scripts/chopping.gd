extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var hit_component_collision_shape: CollisionShape2D


func _ready() -> void:
	if hit_component_collision_shape and is_instance_valid(hit_component_collision_shape):
		hit_component_collision_shape.disabled = true

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if not is_instance_valid(animated_sprite_2d) or !animated_sprite_2d.is_playing():
		print("Animation stopped, transitioning to idle")
		transition.emit("idle")

func _on_enter() -> void:
	print("=== Entering chopping state ===")
	if not is_instance_valid(animated_sprite_2d) or not is_instance_valid(player):
		print("Error: animated_sprite_2d or player not valid")
		return
	
	print("Play direction: ", player.play_direction)
	print("Current tool: ", player.current_tool)
	
	if player.play_direction == Vector2.UP:
		animated_sprite_2d.play("cut_back")
	elif player.play_direction == Vector2.DOWN:
		animated_sprite_2d.play("cut_front")
	elif player.play_direction == Vector2.RIGHT:
		animated_sprite_2d.play("cut_right")
	elif player.play_direction == Vector2.LEFT:
		animated_sprite_2d.play("cut_left")
	else:
		animated_sprite_2d.play("cut_front")
	
	print("Animation played: ", animated_sprite_2d.animation)
	
	if hit_component_collision_shape and is_instance_valid(hit_component_collision_shape):
		if player.play_direction == Vector2.UP:
			hit_component_collision_shape.position = Vector2(3, -20)
		elif player.play_direction == Vector2.DOWN:
			hit_component_collision_shape.position = Vector2(-3, 2)
		elif player.play_direction == Vector2.RIGHT:
			hit_component_collision_shape.position = Vector2(9, 0)
		elif player.play_direction == Vector2.LEFT:
			hit_component_collision_shape.position = Vector2(-9, 0)
		else:
			hit_component_collision_shape.position = Vector2(0, 0)
		hit_component_collision_shape.disabled = false
	else:
		print("Error: hit_component_collision_shape not valid")


func _on_exit() -> void:
	print("=== Exiting chopping state ===")
	if is_instance_valid(animated_sprite_2d):
		animated_sprite_2d.stop()
	if hit_component_collision_shape and is_instance_valid(hit_component_collision_shape):
		hit_component_collision_shape.disabled = true
		hit_component_collision_shape.position = Vector2(0, 0)

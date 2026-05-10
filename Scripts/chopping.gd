extends NodeState

@export var player:Player
@export var animated_sprite_2d : AnimatedSprite2D

var hit_component: HitComponent
var hit_collision_shape: CollisionShape2D


func _ready() -> void:
	if is_instance_valid(player):
		hit_component = player.hit_component
		if hit_component:
			hit_collision_shape = hit_component.get_node_or_null("HitComponentCollisionShape2D") as CollisionShape2D
			if hit_collision_shape:
				hit_collision_shape.disabled = true
			else:
				print("Warning: HitComponentCollisionShape2D not found")

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
	
	print("Entering chopping state")
	
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
	
	if hit_collision_shape and is_instance_valid(hit_collision_shape):
		if player.play_direction == Vector2.UP:
			hit_collision_shape.position = Vector2(3,-20)
		elif player.play_direction == Vector2.DOWN:
			hit_collision_shape.position = Vector2(-3,2)
		elif player.play_direction == Vector2.RIGHT:
			hit_collision_shape.position = Vector2(9,0)
		elif player.play_direction == Vector2.LEFT:
			hit_collision_shape.position = Vector2(-9,0)
		else:
			hit_collision_shape.position = Vector2(0,0)
		hit_collision_shape.disabled = false
		print("Hit collision shape enabled")


func _on_exit() -> void:
	if is_instance_valid(animated_sprite_2d):
		animated_sprite_2d.stop()
	if hit_collision_shape and is_instance_valid(hit_collision_shape):
		hit_collision_shape.disabled = true
		hit_collision_shape.position = Vector2(0,0)

extends NodeState

@export var player:Player
##创建玩家变量
@export var animated_sprite_2d : AnimatedSprite2D
##创建动画变量
@export var hit_component_collision_shape : CollisionShape2D


func _ready() -> void:
	hit_component_collision_shape.disabled = true
	hit_component_collision_shape.position = Vector2(0,0)

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if !animated_sprite_2d.is_playing():
		transition.emit("Idle")
##没执行砍树状态时间，转到发呆

func _on_enter() -> void:
	if player.play_direction == Vector2.UP:
		animated_sprite_2d.play("cut_back")
		hit_component_collision_shape.position = Vector2(3,-20)
	elif player.play_direction == Vector2.DOWN:
		animated_sprite_2d.play("cut_front")
		hit_component_collision_shape.position = Vector2(-3,2)
	elif player.play_direction == Vector2.RIGHT:
		animated_sprite_2d.play("cut_right")
		hit_component_collision_shape.position = Vector2(9,0)
	elif player.play_direction == Vector2.LEFT:
		animated_sprite_2d.play("cut_left")
		hit_component_collision_shape.position = Vector2(-9,0)
	else:
		animated_sprite_2d.play("cut_front")
##砍树动画播放
	hit_component_collision_shape.disabled = false


func _on_exit() -> void:
	animated_sprite_2d.stop()
	hit_component_collision_shape.disabled = true
	hit_component_collision_shape.position = Vector2(0,0)
##退出该状态时停止播放动画

extends NodeState

@export var player : Player
@export var animated_sprite_2D : AnimatedSprite2D

var direction : Vector2

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:

	if player.play_direction == Vector2.UP:
		animated_sprite_2D.play("Idle_back")
	elif player.play_direction == Vector2.DOWN:
		animated_sprite_2D.play("Idle_front")
	elif player.play_direction == Vector2.RIGHT:
		animated_sprite_2D.play("Idle_right")
	elif player.play_direction == Vector2.LEFT:
		animated_sprite_2D.play("Idle_left")
	else:
		animated_sprite_2D.play("Idle_front")
func _on_next_transitions() -> void:
	GameInputEvent.movement_input()
	if GameInputEvent.is_movement_input():
		transition.emit("walk")

	if player.current_tool == DataTypes.Tools.AxeWood && GameInputEvent.usr_tools():
		transition.emit("Chopping")
	if player.current_tool == DataTypes.Tools.TillGround && GameInputEvent.usr_tools():
		transition.emit("Tilling")
	if player.current_tool == DataTypes.Tools.WaterCrops && GameInputEvent.usr_tools():
		transition.emit("Watering")
func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2D.stop()

extends Node

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("save_game"):
		save_game()

func save_game() -> void:
	print("SaveGameManager.save_game() called")
	var save_level_data_component: SaveLevelDataComponent = get_tree().get_first_node_in_group("save_level_data_component")

	if save_level_data_component != null:
		print("Found SaveLevelDataComponent")
		save_level_data_component.save_game()
	else:
		print("Error: SaveLevelDataComponent not found!")


func load_game() -> void:
	print("SaveGameManager.load_game() called")
	var save_level_data_component: SaveLevelDataComponent = get_tree().get_first_node_in_group("save_level_data_component")

	if save_level_data_component != null:
		print("Found SaveLevelDataComponent")
		save_level_data_component.load_game()
	else:
		print("Error: SaveLevelDataComponent not found!")
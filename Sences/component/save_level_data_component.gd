class_name SaveLevelDataComponent
extends Node

var level_scene_name: String
var save_game_data_path: String = "user://game_data/"
var save_file_name: String = "save_%s_game_data.tres"
var game_data_resource: SaveGameDataResource

func _ready() -> void:
	print("SaveLevelDataComponent._ready() called")
	add_to_group("save_level_data_component")
	level_scene_name = get_parent().name
	print("Level scene name: ", level_scene_name)
	
func save_node_data() -> void:
	print("SaveLevelDataComponent.save_node_data() called")
	var nodes = get_tree().get_nodes_in_group("save_data_component")
	print("Found ", len(nodes), " nodes in save_data_component group")

	game_data_resource = SaveGameDataResource.new()

	if nodes != null:
		for node: SaveDataComponent in nodes:
			if node is SaveDataComponent:
				var save_data_resource: NodeDataResource = node.save_data()
				if save_data_resource != null:
					var save_final_resource = save_data_resource.duplicate()
					game_data_resource.save_data_nodes.append(save_final_resource)
					print("Added node data to save: ", node.name)
				
func save_game() -> void:
	print("SaveLevelDataComponent.save_game() called")
	if !DirAccess.dir_exists_absolute(save_game_data_path):
		print("Creating directory: ", save_game_data_path)
		DirAccess.make_dir_absolute(save_game_data_path)
		
	var level_save_file_name: String = save_file_name % level_scene_name
	print("Save file name: ", level_save_file_name)

	save_node_data()

	var result: int = ResourceSaver.save(game_data_resource, save_game_data_path + level_save_file_name)
	if result != OK:
		push_error("Save failed with error code: " + str(result))
	else:
		print("Save successful! Path: ", save_game_data_path + level_save_file_name)
	
func load_game() -> void:
	print("SaveLevelDataComponent.load_game() called")
	var level_save_file_name: String = save_file_name % level_scene_name
	var save_game_path: String = save_game_data_path + level_save_file_name
	print("Load file path: ", save_game_path)

	if !FileAccess.file_exists(save_game_path):
		push_warning("Save file not found: " + save_game_path)
		return

	game_data_resource = ResourceLoader.load(save_game_path)

	if game_data_resource == null:
		push_error("Failed to load save file: " + save_game_path)
		return

	_cleanup_saved_nodes()

	var root_node: Window = get_tree().root

	for resource in game_data_resource.save_data_nodes:
		if resource is NodeDataResource:
			resource._load_data(root_node)

func _cleanup_saved_nodes() -> void:
	for node in get_tree().get_nodes_in_group("save_data_component"):
		if node is SaveDataComponent:
			var parent = node.parent_node
			if parent != null and parent.scene_file_path.is_empty() == false:
				parent.queue_free()

class_name SaveLevelDataComponent
extends Node

var level_scene_name: String
var save_game_data_path: String = "user://game_data/"
var save_file_name: String = "save_%s_game_data.tres"

func _ready() -> void:
	add_to_group("save_level_data_component")
	level_scene_name = get_parent().name

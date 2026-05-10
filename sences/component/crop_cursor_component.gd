class_name  CropCursorComponent
extends Node

@export var tilled_soil_tilemap_layer:TileMapLayer

@onready var player:Player = get_tree().get_first_node_in_group("player")

var corn_plant_scene = preload("res://Sences/object/corn/corn_water.tscn")
var tomato_plant_scene = preload("res://Sences/object/tomato/tomato_water.tscn")

var mouse_position: Vector2 #鼠标位置变量
var cell_position: Vector2i #用于单元格位置向量
var cell_source_id: int
var local_cell_position: Vector2
var distance:float

func _unhandled_input(event: InputEvent) -> void:
	if not is_instance_valid(player):
		return
	
	if event.is_action_pressed("remove_dirt"):
		if player.current_tool == DataTypes.Tools.TillGround:
			get_cell_under_mouse()
			remove_crop()
			
	elif event.is_action_pressed("cut"):
		if player.current_tool == DataTypes.Tools.PlantCorn or player.current_tool == DataTypes.Tools.PlantTomato:
			get_cell_under_mouse()
			add_crop()

func get_cell_under_mouse()->void:
	if not is_instance_valid(tilled_soil_tilemap_layer) or not is_instance_valid(player):
		return
	
	mouse_position = tilled_soil_tilemap_layer.get_local_mouse_position()
	cell_position = tilled_soil_tilemap_layer.local_to_map(mouse_position)
	cell_source_id = tilled_soil_tilemap_layer.get_cell_source_id(cell_position)
	local_cell_position = tilled_soil_tilemap_layer.map_to_local(cell_position)
	distance = player.global_position.distance_to(local_cell_position)
	
func add_crop()->void:
	if distance < 20.0:
		var crop_fields = get_parent().find_child("CropFields")
		if not crop_fields:
			return
		
		if player.current_tool == DataTypes.Tools.PlantCorn:
			var corn_instance = corn_plant_scene.instantiate() as Node2D
			corn_instance.global_position = local_cell_position
			crop_fields.add_child(corn_instance)
			
		if player.current_tool == DataTypes.Tools.PlantTomato:
			var tomato_instance = tomato_plant_scene.instantiate() as Node2D
			tomato_instance.global_position = local_cell_position
			crop_fields.add_child(tomato_instance)
			
func remove_crop()->void:
	if distance < 20.0:
		var crop_fields = get_parent().find_child("CropFields")
		if not crop_fields:
			return
		
		for node in crop_fields.get_children():
			if node is Node2D and node.global_position.distance_to(local_cell_position) < 10.0:
				node.queue_free()

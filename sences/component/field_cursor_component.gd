class_name FieldCursorComponent
extends Node

@export var grass_tilemap_layer : TileMapLayer
@export var tilled_soil_tilemap_layer: TileMapLayer
@export var terrain_set: int = 0
@export var terrain: int = 3

@onready var player: Player = get_tree().get_first_node_in_group("player")

var mouse_position: Vector2
var cell_position: Vector2i
var cell_source_id: int
var local_cell_position: Vector2
var distance:float

func _process(delta: float) -> void:
	if not is_instance_valid(player):
		return
		
	if Input.is_action_just_pressed("cut"):
		if player.current_tool == DataTypes.Tools.TillGround:
			get_cell_under_mouse()
			add_tilled_soil_cell()
			
	if Input.is_action_just_pressed("remove_dirt"):
		if player.current_tool == DataTypes.Tools.TillGround:
			get_cell_under_mouse()
			remove_tilled_soil_cell()

func get_cell_under_mouse()->void:
	if not is_instance_valid(grass_tilemap_layer) or not is_instance_valid(player):
		return
	
	mouse_position = get_tree().root.get_global_mouse_position()
	cell_position = grass_tilemap_layer.world_to_map(mouse_position)
	local_cell_position = grass_tilemap_layer.map_to_local(cell_position)
	distance = player.global_position.distance_to(local_cell_position)
	
func add_tilled_soil_cell()->void:
	if not is_instance_valid(tilled_soil_tilemap_layer):
		print("Error: tilled_soil_tilemap_layer is not valid")
		return
		
	if not is_instance_valid(grass_tilemap_layer):
		print("Error: grass_tilemap_layer is not valid")
		return
		
	if distance < 60.0:
		print("Tilling soil at cell: ", cell_position)
		tilled_soil_tilemap_layer.set_cells_terrain_connect([cell_position], terrain_set, terrain, true)
		print("Soil tilled successfully")
	else:
		print("Too far from soil: distance = ", distance)
		
func remove_tilled_soil_cell()->void:
	if not is_instance_valid(tilled_soil_tilemap_layer):
		return
		
	if distance < 60.0:
		tilled_soil_tilemap_layer.set_cells_terrain_connect([cell_position], terrain_set, -1, true)

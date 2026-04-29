class_name SenceDataResource
extends NodeDataResource

@export var node_name: String
@export var scene_file_path: String

func save_data(node: Node2D) -> void:
	# 先调用父类 (NodeDataResource) 的同名方法，保存通用数据（如全局坐标、路径等）
	super.save_data(node)
	
	# 再保存当前场景特有的数据
	node_name = node.name
	scene_file_path = node.scene_file_path

func _load_data(window: Window) -> void:
	if parent_node_path == null:
		return
	var parent_node = window.get_node_or_null(parent_node_path)
	if parent_node == null:
		return
	var scene_file_resource: Resource = load(scene_file_path)
	var scene_node = scene_file_resource.instantiate() as Node2D
	parent_node.add_child(scene_node)
	scene_node.global_position = global_position

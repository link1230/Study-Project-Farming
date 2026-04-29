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
	var parent_node: Node2D
	var scene_node: Node2D
	
	# parent_node_path 是继承自父类 NodeDataResource 的变量
	if parent_node_path != null:
		parent_node = window.get_node_or_null(parent_node_path)
		
	# node_path 同理，也是继承自父类的变量
	if node_path != null:
		var scene_file_resource: Resource = load(scene_file_path)
		scene_node = scene_file_resource.instantiate() as Node2D
		
		parent_node.add_child(scene_node)
		scene_node.global_position = global_position
		
	# 安全检查：确保父节点和我们要实例化的新节点都成功获取/生成了
	if parent_node != null and scene_node != null:
		# 恢复保存的全局坐标，让它回到存档时的位置
		scene_node.global_position = global_position
		# 【核心步骤】将新实例化的节点正式挂载到场景树上
		parent_node.add_child(scene_node)

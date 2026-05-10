class_name HurtComponent
extends Area2D

@export var tool : DataTypes.Tools = DataTypes.Tools.None

signal hurt


func _ready() -> void:
	print("HurtComponent ready")


func _on_area_entered(area: Area2D) -> void:
	print("=== area_entered called! ===")
	print("Area type: ", area.get_class())
	print("Area name: ", area.name)
	
	if not area is HitComponent:
		print("Area is not HitComponent, ignoring")
		return
		
	var hit_component = area as HitComponent
	
	print("HitComponent detected!")
	print("Current tool: ", hit_component.current_tool)
	print("Required tool: ", tool)
	print("Hit damage: ", hit_component.hit_damage)
	
	if hit_component.current_tool == DataTypes.Tools.AxeWood:
		print("=== Axe detected! Dealing damage! ===")
		hurt.emit(hit_component.hit_damage)
	else:
		print("Wrong tool, not dealing damage")

class_name HurtComponent
extends Area2D

@export var tool : DataTypes.Tools = DataTypes.Tools.None

signal hurt


func _on_area_entered(area: Area2D) -> void:
	if not area is HitComponent:
		return
		
	var hit_component = area as HitComponent
	
	print("Hit detected! Tool: ", hit_component.current_tool, ", Required tool: ", tool)
	
	if hit_component.current_tool == DataTypes.Tools.AxeWood:
		print("Axe detected, dealing damage!")
		hurt.emit(hit_component.hit_damage)

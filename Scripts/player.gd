class_name Player
extends CharacterBody2D
@onready var hit_component: HitComponent = $HitComponent

@export var current_tool : DataTypes.Tools = DataTypes.Tools.None

var play_direction : Vector2

func _ready() -> void:
	ToolsManager.tool_selected.connect(on_tool_selected)
	
func on_tool_selected(tool:DataTypes.Tools) -> void:
	current_tool = tool
	hit_component.current_tool = tool
	
	

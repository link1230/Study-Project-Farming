# TODO：用ai学习该脚本
extends Sprite2D
@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent

var log_scene = preload("res://Sences/object/trees/log.tscn")

func _ready() -> void:
	print("=== SmallTree ready ===")
	print("HurtComponent: ", hurt_component)
	print("DamageComponent: ", damage_component)
	hurt_component.hurt.connect(on_hurt)
	print("Hurt signal connected")
	damage_component.max_damage_reached.connect(on_max_damage_reached)
	print("Max damage signal connected")
	
func on_hurt(hit_damage:int)->void:
	print("=== Tree hurt! ===")
	print("Damage received: ", hit_damage)
	damage_component.apply_damage(hit_damage)
	print("Current damage: ", damage_component.current_damage)
	print("Max damage: ", damage_component.max_damage)
	
	if material and material is ShaderMaterial:
		material.set_shader_parameter("shake_intensity",0.5)
		await get_tree().create_timer(1.0).timeout
		material.set_shader_parameter("shake_intensity",0.0)
	
func on_max_damage_reached()->void :
	print("=== Max damage reached! ===")
	call_deferred("add_log_scene")
	print("Calling add_log_scene deferred")
	queue_free()

func add_log_scene()->void:
	print("=== Adding log scene ===")
	print("Log scene: ", log_scene)
	var log_instance = log_scene.instantiate() as Node2D
	print("Log instance: ", log_instance)
	log_instance.global_position = global_position
	print("Log position: ", log_instance.global_position)
	get_parent().add_child(log_instance)
	print("Log added to scene")

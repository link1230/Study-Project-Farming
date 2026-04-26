class_name GrowthCycleComponent
extends Node

@export var current_growth_state: DataTypes.GrowthState = DataTypes.GrowthState.Germination
@export_range(5,365) var days_until_harvest : int = 7

signal  crop_maturity#设置提醒成熟信号
signal  crop_harvesting

var is_watered: bool
var starting_day: int
var current_day: int

func _ready() -> void:
	DayAndNightCycleManager.time_tick_day.connect(on_time_tick_day)
	
func on_time_tick_day(day:int)->void:
	if is_watered:
		if starting_day == 0:
			starting_day = day

		growth_states(starting_day,day)
		harvest_state(starting_day,day)
#遍历生长状态，达到成熟后退出该函数：
func growth_states(starting_day: int,current_day: int):
	if current_growth_state == DataTypes.GrowthState.Maturity:
		return

	var num_states = 5
	var growth_days_passed = (current_day - starting_day) % num_states
	var state_index = growth_days_passed %num_states + 1
	
	current_growth_state = state_index
	
	var name = DataTypes.GrowthState.keys()[current_growth_state]#数据类型中取当前生长状态
	
	if current_growth_state == DataTypes.GrowthState.Maturity:
		crop_maturity.emit()#成熟了发送状态信号，完成生长状态函数
		
func harvest_state(starting_day:int,current_day:int)->void:
	if current_growth_state == DataTypes.GrowthState.Harvesting:
		return
	
	var days_passed = (current_day - starting_day) % days_until_harvest
	
	if days_passed == days_until_harvest -1:
		current_growth_state = DataTypes.GrowthState.Harvesting
		crop_harvesting.emit()
		
func get_current_growth_state()->DataTypes.GrowthState:#获取当前生长状态的函数
	return current_growth_state#返回当前生长状态
	

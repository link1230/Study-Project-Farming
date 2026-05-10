extends Node
var inventory : Dictionary = Dictionary()

signal inventory_changed

func add_collectable(collectable_name : String)->void:
	if not inventory.has(collectable_name):
		inventory[collectable_name] = 0
	inventory[collectable_name] += 1
	inventory_changed.emit()

func remove_collectable(collectable_name: String) -> void:
	if not inventory.has(collectable_name) or inventory[collectable_name] == null:
		return
	if inventory[collectable_name] > 0:
		inventory[collectable_name] -= 1
	inventory_changed.emit()

func remove_collectable_amount(collectable_name: String, amount: int) -> void:
	if not inventory.has(collectable_name) or inventory[collectable_name] == null:
		return
	inventory[collectable_name] = max(0, inventory[collectable_name] - amount)
	inventory_changed.emit()

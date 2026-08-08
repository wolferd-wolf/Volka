class_name IndustrialContainer
extends Node3D

# Storage Container (Chests, Silos, Hoppers) with fixed grid slots

@export var max_slots: int = 27
var inventory: Array[ItemEntity] = []

func add_item(item: ItemEntity) -> bool:
	if inventory.size() < max_slots:
		inventory.append(item)
		return true
	return false

func remove_first_item() -> ItemEntity:
	if not inventory.is_empty():
		return inventory.pop_front()
	return null

class_name CargoCarriage
extends CharacterBody3D

# Industrial Freight Wagon for Bulk Material Logistics

@export var max_cargo_slots: int = 36
var cargo_inventory: Array[ItemEntity] = []

func load_cargo(item: ItemEntity) -> bool:
	if cargo_inventory.size() < max_cargo_slots:
		cargo_inventory.append(item)
		return true
	return false

func unload_cargo() -> ItemEntity:
	if not cargo_inventory.is_empty():
		return cargo_inventory.pop_front()
	return null

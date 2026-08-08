class_name HotbarUI
extends Control

# Android Touch Hotbar UI Component

signal selected_slot_changed(slot_index: int, block_type: int)

@export var slot_count: int = 9
var active_slot_index: int = 0
var hotbar_slots: Array[Dictionary] = []

func _ready() -> void:
	for i in range(slot_count):
		hotbar_slots.append({
			"block_type": VoxelTypes.BlockType.GRASS if i == 0 else VoxelTypes.BlockType.DIRT,
			"count": 64
		})

func select_slot(index: int) -> void:
	if index >= 0 and index < slot_count:
		active_slot_index = index
		var selected: Dictionary = hotbar_slots[active_slot_index]
		emit_signal("selected_slot_changed", active_slot_index, selected["block_type"])

class_name ItemEntity
extends Node3D

# Item entity transported on conveyor belts or dropped in the voxel world

@export var item_id: String = "iron_ingot"
@export var stack_size: int = 1
@export var max_stack: int = 64

var belt_progress: float = 0.0 # 0.0 to 1.0 along current belt segment
var visual_mesh: MeshInstance3D

func _ready() -> void:
	visual_mesh = MeshInstance3D.new()
	add_child(visual_mesh)

func create_item(id: String, count: int = 1) -> void:
	item_id = id
	stack_size = count

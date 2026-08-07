class_name VoxelWorld
extends Node3D

@export var chunk_size: int = 16
@export var render_distance: int = 4

var loaded_chunks: Dictionary = {}

func _ready() -> void:
	print("TEKNIK Voxel World initialized.")
	generate_initial_world()

func generate_initial_world() -> void:
	for x in range(-render_distance, render_distance):
		for z in range(-render_distance, render_distance):
			load_chunk(Vector3i(x, 0, z))

func load_chunk(coord: Vector3i) -> void:
	if not loaded_chunks.has(coord):
		var chunk = Node3D.new()
		chunk.name = "Chunk_%d_%d_%d" % [coord.x, coord.y, coord.z]
		add_child(chunk)
		loaded_chunks[coord] = chunk

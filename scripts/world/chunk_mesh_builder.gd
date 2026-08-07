class_name ChunkMeshBuilder
extends RefCounted

static func build_chunk_mesh(chunk_data: Array, chunk_size: int) -> ArrayMesh:
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)

	for x in range(chunk_size):
		for y in range(chunk_size):
			for z in range(chunk_size):
				var block_idx: int = x * chunk_size * chunk_size + y * chunk_size + z
				var block: int = chunk_data[block_idx]
				if block == VoxelTypes.BlockType.AIR:
					continue

				var pos = Vector3(x, y, z)
				add_cube_faces(st, pos)

	st.generate_normals()
	return st.commit()

static func add_cube_faces(st: SurfaceTool, pos: Vector3) -> void:
	# Front face
	st.add_vertex(pos + Vector3(0, 0, 1))
	st.add_vertex(pos + Vector3(1, 0, 1))
	st.add_vertex(pos + Vector3(1, 1, 1))

	st.add_vertex(pos + Vector3(0, 0, 1))
	st.add_vertex(pos + Vector3(1, 1, 1))
	st.add_vertex(pos + Vector3(0, 1, 1))

class_name ProceduralGenerator
extends RefCounted

var surface_noise: FastNoiseLite
var cave_noise: FastNoiseLite
var ore_noise: FastNoiseLite

func _init(seed_val: int = 1337) -> void:
	surface_noise = FastNoiseLite.new()
	surface_noise.seed = seed_val
	surface_noise.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	surface_noise.frequency = 0.01

	cave_noise = FastNoiseLite.new()
	cave_noise.seed = seed_val + 100
	cave_noise.noise_type = FastNoiseLite.TYPE_PERLIN
	cave_noise.frequency = 0.03

	ore_noise = FastNoiseLite.new()
	ore_noise.seed = seed_val + 200
	ore_noise.noise_type = FastNoiseLite.TYPE_CELLULAR
	ore_noise.frequency = 0.05

func get_block_at(world_pos: Vector3i) -> VoxelTypes.BlockType:
	var x: int = world_pos.x
	var y: int = world_pos.y
	var z: int = world_pos.z

	var height: int = int((surface_noise.get_noise_2d(x, z) + 1.0) * 0.5 * 40.0) + 10

	if y > height:
		return VoxelTypes.BlockType.AIR

	# Check for 3D cave generation
	if y < height - 2:
		var cave_val: float = cave_noise.get_noise_3d(x, y, z)
		if cave_val > 0.35:
			return VoxelTypes.BlockType.AIR

	if y == height:
		return VoxelTypes.BlockType.GRASS
	elif y > height - 4:
		return VoxelTypes.BlockType.DIRT
	else:
		# Underground ore deposits
		var ore_val: float = ore_noise.get_noise_3d(x, y, z)
		if ore_val > 0.6:
			return VoxelTypes.BlockType.IRON_ORE
		elif ore_val > 0.45:
			return VoxelTypes.BlockType.COAL_ORE
		return VoxelTypes.BlockType.STONE

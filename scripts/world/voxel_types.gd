class_name VoxelTypes
extends Node

enum BlockType {
	AIR = 0,
	GRASS = 1,
	DIRT = 2,
	STONE = 3,
	SAND = 4,
	GRAVEL = 5,
	OAK_LOG = 6,
	OAK_LEAVES = 7,
	COAL_ORE = 8,
	IRON_ORE = 9,
	COPPER_ORE = 10,
	WATER = 11
}

static func is_transparent(block_type: BlockType) -> bool:
	return block_type == BlockType.AIR or block_type == BlockType.WATER or block_type == BlockType.OAK_LEAVES

class_name CraftingUI
extends Control

# Mobile Crafting & Manufacturing Interface

var available_recipes: Array[Dictionary] = [
	{
		"output": VoxelTypes.BlockType.OAK_LOG,
		"input": [VoxelTypes.BlockType.DIRT, VoxelTypes.BlockType.GRASS],
		"count": 4
	}
]

func craft_item(recipe_index: int) -> void:
	if recipe_index >= 0 and recipe_index < available_recipes.size():
		var recipe: Dictionary = available_recipes[recipe_index]
		print("Crafted item: ", recipe["output"])

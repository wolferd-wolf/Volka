class_name SchematicUI
extends Control

# Touch UI Overlay for Selecting and Placing Factory Blueprints

@export var schematic_manager: SchematicManager

func _on_place_blueprint_pressed(blueprint_name: String) -> void:
	var path = "user://schematics/" + blueprint_name + ".json"
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var content = file.get_as_text()
		file.close()
		
		var schematic = SchematicData.new()
		if schematic.deserialize_from_json(content):
			if schematic_manager:
				schematic_manager.paste_schematic(Vector3i.ZERO, schematic)

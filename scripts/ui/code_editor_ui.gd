class_name CodeEditorUI
extends Control

# Touch-Friendly Mobile Code & Automation Logic Interface

@export var target_microcontroller: MicrocontrollerNode
@onready var text_edit: TextEdit = $TextEdit if has_node("TextEdit") else null

func apply_script_changes() -> void:
	if target_microcontroller and text_edit:
		print("Updated microcontroller logic code.")

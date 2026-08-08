class_name MobileHUD
extends CanvasLayer

# Android HUD Overlay with Multi-Touch Controls and Camera Touch Look

@export var player_controller: CharacterBody3D
@export var block_interaction: Node

@onready var movement_joystick: TouchJoystick = $MovementJoystick if has_node("MovementJoystick") else null

var camera_touch_index: int = -1
var camera_sensitivity: float = 0.005

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		# Touch right side of screen for camera look
		if event.position.x > get_viewport().get_visible_rect().size.x * 0.5:
			if event.pressed and camera_touch_index == -1:
				camera_touch_index = event.index
			elif not event.pressed and event.index == camera_touch_index:
				camera_touch_index = -1

	elif event is InputEventScreenDrag and event.index == camera_touch_index:
		if player_controller and player_controller.has_node("Camera3D"):
			var cam: Camera3D = player_controller.get_node("Camera3D")
			cam.rotate_x(-event.relative.y * camera_sensitivity)
			player_controller.rotate_y(-event.relative.x * camera_sensitivity)

func _on_break_button_pressed() -> void:
	if block_interaction and block_interaction.has_method("break_targeted_block"):
		block_interaction.break_targeted_block()

func _on_place_button_pressed() -> void:
	if block_interaction and block_interaction.has_method("place_block_at_target"):
		block_interaction.place_block_at_target(VoxelTypes.BlockType.GRASS)

class_name TouchJoystick
extends Control

# Mobile Virtual Touch Joystick for Android Input

signal joystick_vector_changed(output_vector: Vector2)

@export var max_clamp_distance: float = 64.0
@export var deadzone: float = 0.1

var is_pressed: bool = false
var touch_index: int = -1
var joystick_center: Vector2 = Vector2.ZERO
var current_output: Vector2 = Vector2.ZERO

@onready var base_ring: Control = $BaseRing if has_node("BaseRing") else null
@onready var touch_knob: Control = $TouchKnob if has_node("TouchKnob") else null

func _gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed and touch_index == -1:
			touch_index = event.index
			is_pressed = true
			joystick_center = event.position
			update_joystick(event.position)
		elif not event.pressed and event.index == touch_index:
			reset_joystick()

	elif event is InputEventScreenDrag and event.index == touch_index:
		update_joystick(event.position)

func update_joystick(touch_pos: Vector2) -> void:
	var delta: Vector2 = touch_pos - joystick_center
	if delta.length() < deadzone * max_clamp_distance:
		current_output = Vector2.ZERO
	else:
		var clamped_delta: Vector2 = delta.limit_length(max_clamp_distance)
		current_output = clamped_delta / max_clamp_distance
		if touch_knob:
			touch_knob.position = clamped_delta
			
	emit_signal("joystick_vector_changed", current_output)

func reset_joystick() -> void:
	is_pressed = false
	touch_index = -1
	current_output = Vector2.ZERO
	if touch_knob:
		touch_knob.position = Vector2.ZERO
	emit_signal("joystick_vector_changed", Vector2.ZERO)

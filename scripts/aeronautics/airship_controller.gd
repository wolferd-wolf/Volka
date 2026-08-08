class_name AirshipController
extends Node

# Flight Helm Controller for Steering and Altitude Management

@export var target_airship: AirshipAssembly

var throttle_input: float = 0.0
var pitch_input: float = 0.0
var yaw_input: float = 0.0

func set_flight_inputs(throttle: float, pitch: float, yaw: float) -> void:
	throttle_input = clamp(throttle, -1.0, 1.0)
	pitch_input = clamp(pitch, -1.0, 1.0)
	yaw_input = clamp(yaw, -1.0, 1.0)
	
	if target_airship:
		target_airship.apply_torque(Vector3(pitch_input * 500.0, yaw_input * 1000.0, 0.0))

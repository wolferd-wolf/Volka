class_name BuoyancyCell
extends Node3D

# Buoyancy Gas Cell generating vertical aerodynamic lift force

@export var cell_volume: float = 100.0 # Cubic meters
@export var max_temperature: float = 300.0 # Celsius

var current_temperature: float = 20.0
var net_lift_force: float = 0.0

func update_buoyancy(burner_heat: float, delta: float) -> float:
	if burner_heat > 0.0:
		current_temperature = move_toward(current_temperature, max_temperature, burner_heat * 10.0 * delta)
	else:
		current_temperature = move_toward(current_temperature, 20.0, 2.0 * delta)
		
	# Calculate buoyant lift force: F = air_density * volume * g * temperature_ratio
	var temp_ratio: float = (current_temperature - 20.0) / (max_temperature - 20.0)
	net_lift_force = cell_volume * 9.8 * temp_ratio
	return net_lift_force

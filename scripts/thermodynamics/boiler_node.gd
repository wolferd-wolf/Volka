class_name BoilerNode
extends Node3D

# Thermodynamic Boiler converting fuel and water into pressurized steam

signal steam_produced(pressure: float)
signal boiler_overheated()

@export var max_temperature: float = 500.0 # Celsius
@export var max_water_capacity: float = 1000.0 # Liters
@export var max_steam_capacity: float = 2000.0 # Liters

var current_temperature: float = 20.0
var water_level: float = 500.0
var steam_level: float = 0.0
var fuel_time_remaining: float = 0.0

func _process(delta: float) -> void:
	if fuel_time_remaining > 0.0:
		fuel_time_remaining -= delta
		current_temperature = move_toward(current_temperature, max_temperature, 15.0 * delta)
	else:
		current_temperature = move_toward(current_temperature, 20.0, 5.0 * delta)
		
	# Convert water to steam if temperature > 100C
	if current_temperature >= 100.0 and water_level > 0.0:
		var boil_rate: float = (current_temperature / 100.0) * 10.0 * delta
		var converted_water: float = min(water_level, boil_rate)
		water_level -= converted_water
		steam_level = min(max_steam_capacity, steam_level + converted_water * 1.6)
		emit_signal("steam_produced", steam_level / max_steam_capacity)
		
	if current_temperature >= max_temperature:
		emit_signal("boiler_overheated")

func add_fuel(burn_time: float) -> void:
	fuel_time_remaining += burn_time

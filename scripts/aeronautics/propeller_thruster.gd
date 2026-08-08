class_name PropellerThruster
extends KineticNode

# Rotational Propeller Thruster converting kinetic RPM into directional thrust

@export var blade_diameter: float = 2.0
@export var thrust_multiplier: float = 0.5

var current_thrust_vector: Vector3 = Vector3.ZERO

func _process(delta: float) -> void:
	super._process(delta)
	
	if abs(current_rpm) > 0.001:
		# Calculate thrust magnitude proportional to RPM squared
		var thrust_magnitude: float = pow(current_rpm * 0.1, 2.0) * thrust_multiplier
		current_thrust_vector = -global_transform.basis.z * thrust_magnitude * rotation_direction
	else:
		current_thrust_vector = Vector3.ZERO

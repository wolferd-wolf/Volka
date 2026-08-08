class_name AirshipAssembly
extends RigidBody3D

# Movable Flying Airship Structure with Walkable Physics Platform

@export var structure_mass: float = 5000.0 # Kilograms
@export var linear_drag: float = 0.05
@export var angular_drag: float = 0.1

var buoyancy_cells: Array[BuoyancyCell] = []
var thrusters: Array[PropellerThruster] = []
var local_voxels: Dictionary = {} # Vector3i -> BlockType

func _ready() -> void:
	mass = structure_mass
	linear_damp = linear_drag
	angular_damp = angular_drag

func _physics_process(delta: float) -> void:
	var total_lift: float = 0.0
	for cell in buoyancy_cells:
		total_lift += cell.update_buoyancy(1.0, delta)
		
	# Apply buoyant lift force at center of mass
	apply_central_force(Vector3.UP * total_lift)
	
	# Apply thruster forces at their local positions
	for thruster in thrusters:
		if thruster.current_thrust_vector.length_squared() > 0.001:
			var relative_pos: Vector3 = thruster.global_position - global_position
			apply_force(thruster.current_thrust_vector, relative_pos)

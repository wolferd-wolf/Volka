class_name Inserter
extends KineticNode

# Mechanical Inserter Arm for item extraction and placement

@export var swing_speed: float = 1.0
var held_item: ItemEntity = null
var current_angle: float = 0.0 # 0 to PI
var is_returning: bool = false

func _process(delta: float) -> void:
	super._process(delta)
	if abs(current_rpm) > 0.001:
		update_inserter_arm(delta)

func update_inserter_arm(delta: float) -> void:
	var angular_step: float = (current_rpm * 0.05) * delta
	if is_returning:
		current_angle -= angular_step
		if current_angle <= 0.0:
			current_angle = 0.0
			is_returning = false
			drop_held_item()
	else:
		current_angle += angular_step
		if current_angle >= PI:
			current_angle = PI
			is_returning = true

	rotation.y = current_angle

func drop_held_item() -> void:
	if held_item:
		# Transfer held item to destination container/belt
		held_item = null

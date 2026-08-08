class_name ConveyorBelt
extends KineticNode

# Physical Conveyor Belt component driven by kinetic rotational power

@export var belt_length: float = 1.0
@export var max_item_capacity: int = 4

var item_queue: Array[ItemEntity] = []
var next_belt: ConveyorBelt = null

func _process(delta: float) -> void:
	super._process(delta)
	if abs(current_rpm) > 0.001:
		process_item_transport(delta)

func process_item_transport(delta: float) -> void:
	var move_speed: float = abs(current_rpm) * 0.02 * delta
	
	var idx: int = 0
	while idx < item_queue.size():
		var item: ItemEntity = item_queue[idx]
		item.belt_progress += move_speed
		
		# Interpolate 3D visual position along belt direction
		var start_pos: Vector3 = global_position - transform.basis.z * 0.5
		var end_pos: Vector3 = global_position + transform.basis.z * 0.5
		item.global_position = start_pos.lerp(end_pos, item.belt_progress)
		
		# Transfer item to connected downstream belt if reached end
		if item.belt_progress >= 1.0:
			if next_belt and next_belt.can_accept_item():
				item_queue.remove_at(idx)
				item.belt_progress = 0.0
				next_belt.accept_item(item)
				continue
			else:
				item.belt_progress = 1.0
		idx += 1

func can_accept_item() -> bool:
	return item_queue.size() < max_item_capacity

func accept_item(item: ItemEntity) -> void:
	if can_accept_item():
		item_queue.append(item)
		if item.get_parent() != self:
			item.reparent(self)

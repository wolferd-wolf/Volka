class_name MainGameManager
extends Node3D

# Primary Game Scene Controller connecting Player, World, Logistics, and Touch HUD

@onready var world_chunk_manager: WorldChunkManager = $WorldChunkManager if has_node("WorldChunkManager") else null
@onready var player: PlayerController = $PlayerController if has_node("PlayerController") else null
@onready var mobile_hud: MobileHUD = $MobileHUD if has_node("MobileHUD") else null

var kinetic_sources: Array[KineticNode] = []

func _ready() -> void:
	print("TEKNIK Main Game Manager Starting...")
	if world_chunk_manager:
		world_chunk_manager.update_chunks_around_player(Vector3.ZERO)

func _process(delta: float) -> void:
	if player and world_chunk_manager:
		world_chunk_manager.update_chunks_around_player(player.global_position)
		
	# Solve kinetic rotational mechanical energy graph
	if not kinetic_sources.is_empty():
		RotationalNetwork.solve_network(kinetic_sources)

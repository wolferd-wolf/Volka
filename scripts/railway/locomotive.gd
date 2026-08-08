class_name Locomotive
extends CharacterBody3D

# Steam-Powered Railway Locomotive Engine

signal station_reached(station_name: String)

@export var max_speed: float = 15.0
@export var acceleration: float = 2.5
@export var max_fuel_capacity: float = 100.0

var current_speed: float = 0.0
var target_speed: float = 0.0
var current_track: RailTrack = null
var track_progress: float = 0.0
var fuel_level: float = 100.0
var coupled_carriages: Array[Node3D] = []

func _physics_process(delta: float) -> void:
	if fuel_level > 0.0 and target_speed > 0.0:
		fuel_level = max(0.0, fuel_level - delta * 0.5)
		current_speed = move_toward(current_speed, target_speed, acceleration * delta)
	else:
		current_speed = move_toward(current_speed, 0.0, acceleration * 1.5 * delta)
		
	if current_track and current_speed > 0.0:
		var track_len: float = current_track.curve_path.get_baked_length()
		track_progress += (current_speed * delta) / track_len
		
		if track_progress >= 1.0:
			track_progress = 0.0
			advance_to_next_track()
			
		global_transform = current_track.global_transform * current_track.get_sample_transform(track_progress)

func advance_to_next_track() -> void:
	if current_track and not current_track.connected_tracks.is_empty():
		current_track = current_track.connected_tracks[0]

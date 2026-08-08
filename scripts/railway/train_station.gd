class_name TrainStation
extends Node3D

# Automated Train Station with Conveyor Loading & Unloading

@export var station_name: String = "Central_Iron_Depot"
@export var connected_track: RailTrack

var stopped_locomotive: Locomotive = null
var stop_duration_remaining: float = 0.0

func _process(delta: float) -> void:
	if stopped_locomotive and stop_duration_remaining > 0.0:
		stop_duration_remaining -= delta
		if stop_duration_remaining <= 0.0:
			resume_train_route()

func on_train_arrived(train: Locomotive, wait_time: float = 10.0) -> void:
	stopped_locomotive = train
	stopped_locomotive.target_speed = 0.0
	stop_duration_remaining = wait_time

func resume_train_route() -> void:
	if stopped_locomotive:
		stopped_locomotive.target_speed = stopped_locomotive.max_speed
		stopped_locomotive = null

class_name RailTrack
extends Node3D

# Physical 3D Rail Track Segment with Bezier Path Curves

enum TrackType { STRAIGHT, CURVE, SLOPE_UP, SLOPE_DOWN }

@export var track_type: TrackType = TrackType.STRAIGHT
@export var track_length: float = 2.0

var curve_path: Curve3D
var connected_tracks: Array[RailTrack] = []

func _ready() -> void:
	setup_track_curve()

func setup_track_curve() -> void:
	curve_path = Curve3D.new()
	var start_pt: Vector3 = Vector3(0, 0, -track_length * 0.5)
	var end_pt: Vector3 = Vector3(0, 0, track_length * 0.5)
	
	if track_type == TrackType.STRAIGHT:
		curve_path.add_point(start_pt)
		curve_path.add_point(end_pt)
	elif track_type == TrackType.CURVE:
		curve_path.add_point(start_pt, Vector3.ZERO, Vector3(0, 0, 1.0))
		curve_path.add_point(Vector3(track_length * 0.5, 0, 0), Vector3(-1.0, 0, 0), Vector3.ZERO)

func get_sample_transform(progress: float) -> Transform3D:
	if curve_path and curve_path.get_point_count() > 1:
		var pos: Vector3 = curve_path.sample_baked(progress * curve_path.get_baked_length())
		return Transform3D(Basis(), pos)
	return global_transform

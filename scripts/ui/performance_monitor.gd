class_name PerformanceMonitor
extends Control

# Android Performance & Frame Rate HUD Overlay

@onready var fps_label: Label = $FPSLabel if has_node("FPSLabel") else null
@onready var draw_calls_label: Label = $DrawCallsLabel if has_node("DrawCallsLabel") else null

func _process(_delta: float) -> void:
	var fps: float = Performance.get_monitor(Performance.TIME_FPS)
	var process_time: float = Performance.get_monitor(Performance.TIME_PROCESS) * 1000.0
	var draw_calls: int = Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME)
	var objects: int = Performance.get_monitor(Performance.RENDER_TOTAL_OBJECTS_IN_FRAME)
	
	if fps_label:
		fps_label.text = "FPS: %d (%.2f ms)" % [int(fps), process_time]
	if draw_calls_label:
		draw_calls_label.text = "Draw Calls: %d | Objects: %d" % [draw_calls, objects]

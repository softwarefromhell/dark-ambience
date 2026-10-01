extends Node

#===============================================================================
# VARIABLES
#===============================================================================

@export var idle_threshold: float = 5.0

var last_input_time: float = 0.0
var is_idle: bool = false

#===============================================================================
# METHODS
#===============================================================================

func _ready() -> void:
	last_input_time = Time.get_ticks_msec() / 1000.0


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion or event is InputEventKey or event is InputEventMouseButton:
		last_input_time = Time.get_ticks_msec() / 1000.0
		
		if is_idle:
			is_idle = false
			Event.user_activity_detected.emit()

func _process(_delta: float) -> void:
	var current_time: float = Time.get_ticks_msec() / 1000.0
	
	if not is_idle and (current_time - last_input_time) >= idle_threshold:
		if AppState.current_state != AppState.State.SCREENSAVER:
			is_idle = true
			Event.idle_detected.emit()

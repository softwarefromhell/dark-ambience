extends Node

#===============================================================================
# VARIABLES
#===============================================================================

@onready var main_window: Control = $MainWindow
@onready var screensaver: Control = $Screensaver

#===============================================================================
# METHODS
#===============================================================================

func _ready() -> void:
	Event.idle_detected.connect(on_idle_detected)
	Event.user_activity_detected.connect(on_user_activity)
	Event.state_changed.connect(on_state_changed)
	
	screensaver.hide()
	
	AppState.change_state(AppState.State.MAIN_WINDOW)


func on_idle_detected() -> void:
	AppState.change_state(AppState.State.SCREENSAVER)


func on_user_activity() -> void:
	if AppState.current_state == AppState.State.SCREENSAVER:
		AppState.change_state(AppState.State.MAIN_WINDOW)


func on_state_changed(_old_state: AppState.State, new_state: AppState.State) -> void:
	match new_state:
		AppState.State.MAIN_WINDOW:
			main_window.show()
			screensaver.hide()
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
		AppState.State.BACKGROUND:
			main_window.hide()
			screensaver.hide()
		
		AppState.State.SCREENSAVER:
			main_window.hide()
			screensaver.show()
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

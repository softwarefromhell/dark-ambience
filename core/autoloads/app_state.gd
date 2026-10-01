extends Node

#===============================================================================
# ENUMS
#===============================================================================

enum State {
	MAIN_WINDOW,
	BACKGROUND,
	SCREENSAVER
}

#===============================================================================
# VARIABLES
#===============================================================================

var current_state: State = State.MAIN_WINDOW

#===============================================================================
# METHODS
#===============================================================================

func change_state(new_state: State) -> void:
	if current_state == new_state:
		return
	
	var old_state = current_state
	current_state = new_state
	
	Event.state_changed.emit(old_state, new_state)

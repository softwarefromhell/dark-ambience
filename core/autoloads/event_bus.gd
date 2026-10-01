extends Node

#===============================================================================
# SIGNALS
#===============================================================================

signal state_changed(old_state: AppState.State, new_state: AppState.State)
signal idle_detected
signal user_activity_detected
